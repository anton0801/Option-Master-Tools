import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var stocksManager: StocksManager
    @EnvironmentObject var portfolioManager: PortfolioManager
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack(alignment: .leading) {
                        Image("portfolio_bg")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 50, height: 150)
                        
                        VStack(alignment: .leading) {
                            Spacer()
                                                        
                            Text("Portfolio")
                                .font(.custom("Ubuntu-Bold", size: 24))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Holding value")
                                .font(.custom("Ubuntu-Bold", size: 14))
                                .foregroundColor(.white)
                            Text("$\(portfolioManager.calculateTotalFundHoldings(stocksManager: stocksManager).formattedToTwoDecimalPlaces())")
                                .font(.custom("Ubuntu-Bold", size: 32))
                                .foregroundColor(.white)
                                .padding(.top, 1)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    Button {
                        selectedTab = 2
                    } label: {
                        Image("complete_btn")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    }
                    .padding(.top)
                    
                    Text("Your portfolio")
                       .font(.custom("Ubuntu-Bold", size: 24))
                       .frame(width: UIScreen.main.bounds.width - 60, alignment: .leading)
                       .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                       .padding([.top, .horizontal], 4)
                       .multilineTextAlignment(.leading)
                    
                    if portfolioManager.holdings.isEmpty {
                        HStack {
                           Spacer()
                           Text("Your portfolio is empty!")
                              .font(.custom("Ubuntu-Medium", size: 16))
                              .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                           Spacer()
                        }
                        .padding(.top, 82)
                    } else {
                        ForEach(stocksManager.stocksData.filter { a in
                            portfolioManager.holdings.contains { $0.tiker == a.ticker }
                        }.sorted(by: { $0.marketCap > $1.marketCap }), id: \.id) { stockItem in
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    PortfolioView(selectedTab: .constant(1))
        .environmentObject(StocksManager())
        .environmentObject(PortfolioManager())
}
