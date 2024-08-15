import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    
    @EnvironmentObject var stocksManager: StocksManager
    @EnvironmentObject var portfolioManager: PortfolioManager
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    ZStack {
                        Image("welcome_bg")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 50, height: 160)
                        VStack(alignment: .leading) {
                            Spacer()
                            
                            Text("Welcome")
                                .font(.custom("Ubuntu-Bold", size: 14))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("At what stage is the market today?")
                                .font(.custom("Ubuntu-Bold", size: 18))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                withAnimation(.linear(duration: 0.3)) {
                                    selectedTab = 2
                                }
                            } label: {
                                Image("check_btn")
                                    .resizable()
                                    .frame(width: 80, height: 40)
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, height: 160)
                    Spacer()
                }
                
                Text("Popular")
                    .font(.custom("Ubuntu-Bold", size: 24))
                    .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    .padding()
                
                ScrollView {
                    ForEach(stocksManager.stocksData.filter { !$0.ticker.isEmpty }.sorted(by: { $0.marketCap > $1.marketCap }), id: \.id) { stockItem in
                        NavigationLink(destination: StockDetailsView(stockItem: stockItem)
                            .environmentObject(stocksManager)
                            .environmentObject(portfolioManager)
                            .navigationBarBackButtonHidden(true)) {
                            StockItemView(stockItem: stockItem)
                                .environmentObject(stocksManager)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MainView(selectedTab: .constant(0))
        .environmentObject(StocksManager())
        .environmentObject(PortfolioManager())
}

struct StockItemView: View {
    
    var stockItem: StockItem
    @EnvironmentObject var stocksManager: StocksManager
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: "\(stockItem.branding.iconUrl)?apiKey=\(String.apiKey)"))
                .resizable()
                .frame(width: 52, height: 52)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(52)
            Text(stockItem.name)
                .font(.custom("Ubuntu-Bold", size: 14))
                .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                .padding(.leading, 4)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                let openClosePrices = stocksManager.stockPrices.filter { $0.symbol == stockItem.ticker }[0]
                Text("$\(openClosePrices.preMarket.formattedToTwoDecimalPlaces())")
                    .font(.custom("Ubuntu-Bold", size: 15))
                    .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                if openClosePrices.preMarketChangePercentage > 0 {
                    Text("+\(openClosePrices.preMarketChangePercentage.formattedToTwoDecimalPlaces())%")
                        .font(.custom("Ubuntu-Medium", size: 11))
                        .padding(.top, 2)
                        .foregroundColor(Color.init(red: 33/255, green: 191/255, blue: 115/255))
                } else {
                    Text("\(openClosePrices.preMarketChangePercentage.formattedToTwoDecimalPlaces())%")
                        .font(.custom("Ubuntu-Medium", size: 11))
                        .padding(.top, 2)
                        .foregroundColor(Color.init(red: 217/255, green: 4/255, blue: 41/255))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                .fill(.white)
                .frame(height: 80)
        )
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 1, trailing: 16))
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 6)
    }
    
}

extension Double {
    func formattedToTwoDecimalPlaces() -> String {
            return String(format: "%.2f", self)
        }
}
