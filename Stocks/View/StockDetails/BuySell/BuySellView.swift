import SwiftUI
import UIKit

enum BuySellType {
    case buy, sell
}

struct BuySellView: View {
    
    var type: BuySellType
    var stockItem: StockItem
    
    @State var count: String = "0"
    @FocusState private var isFocused: Bool
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var stocksManager: StocksManager
    @EnvironmentObject var portfolioManager: PortfolioManager
    @State var showError = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    Image("arrow_back")
                        .resizable()
                        .frame(width: 14, height: 24)
                }
                
                Text("\(type == .buy ? "Buy" : "Sell") \(stockItem.ticker)")
                    .font(.custom("Ubuntu-Bold", size: 16))
                    .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    .padding(.leading, 4)
                
                Spacer()
            }
            .padding()
            
            HStack {
                Spacer()
                TextField("", text: $count)
                    .font(.custom("Ubuntu-Bold", size: 52))
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                    .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    .keyboardType(.decimalPad)
                Spacer()
            }
            .padding(.top, 62)
            
            let openClosePrices = stocksManager.stockPrices.filter { $0.symbol == stockItem.ticker }[0]
//            let openClosePrices = OpenCloseResponse(symbol: "MSFT", open: 243.21, high: 246.213, low: 242.123, volume: 2132413, preMarket: 245.12)
            
            Text("Min \(openClosePrices.preMarket.formattedToTwoDecimalPlaces())")
                .font(.custom("Ubuntu-Medium", size: 16))
                .foregroundColor(Color.init(red: 108/255, green: 117/255, blue: 125/255))
                .padding(.top, 32)
            
            Spacer()
            
            Button {
                let money = Double(count) ?? 0.0
                if money >= openClosePrices.preMarket {
                    if type == .buy {
                        portfolioManager.buyStocks(stocksManager: stocksManager, stockItem: stockItem, money: money)
                        presMode.wrappedValue.dismiss()
                    } else {
                        let res = portfolioManager.sellStocks(stocksManager: stocksManager, stockItem: stockItem, money: money)
                        if res {
                            presMode.wrappedValue.dismiss()
                        } else {
                            showError = true
                        }
                    }
                }
            } label: {
                Text("\(type == .buy ? "BUY" : "SELL")")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(.custom("Ubuntu-Medium", size: 16))
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.init(red: 109/255, green: 40/255, blue: 243/255),
                                        Color.init(red: 146/255, green: 45/255, blue: 237/255),
                                        Color.init(red: 170/255, green: 48/255, blue: 232/255)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: .infinity, height: 50)
                    )
                    .padding(24)
            }
        }
        .onAppear {
            self.isFocused = true
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Sell error"), message: Text("Some went wrong!"), dismissButton: .cancel(Text("Ok")))
        }
    }
}

#Preview {
    BuySellView(type: .buy, stockItem: StockItem(ticker: "MSFT", name: "Microsoft Corp", market: "stocks", locale: "us", primaryExchange: "XNAS", type: "CS", marketCap: 3098230993286.8403, phoneNumber: "425-882-8080", description: "Microsoft develops and licenses consumer and enterprise software. It is known for its Windows operating systems and Office productivity suite. The company is organized into three equally sized broad segments: productivity and business processes (legacy Microsoft Office, cloud-based Office 365, Exchange, SharePoint, Skype, LinkedIn, Dynamics), intelligence cloud (infrastructure- and platform-as-a-service offerings Azure, Windows Server OS, SQL Server), and more personal computing (Windows Client, Xbox, Bing search, display advertising, and Surface laptops, tablets, and desktops).", homepageUrl: "https://www.microsoft.com", branding: StockBranding(logoUrl: "https://api.polygon.io/v1/reference/company-branding/bWljcm9zb2Z0LmNvbQ/images/2024-08-01_logo.svg", iconUrl: "https://api.polygon.io/v1/reference/company-branding/bWljcm9zb2Z0LmNvbQ/images/2024-08-01_icon.jpeg")))
        .environmentObject(StocksManager())
        .environmentObject(PortfolioManager())
}
