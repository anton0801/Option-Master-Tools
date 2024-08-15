import SwiftUI

struct MarketView: View {
    
    @EnvironmentObject var stocksManager: StocksManager
    @EnvironmentObject var portfolioManager: PortfolioManager
    @State var marketStatus = 0.0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Market is \(marketStatus < 0.0 ? "down" : "up")")
                        .font(.custom("Ubuntu-Medium", size: 24))
                        .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    if marketStatus < 0.0 {
                        Text("\(marketStatus.formattedToTwoDecimalPlaces())%")
                            .font(.custom("Ubuntu-Medium", size: 24))
                            .foregroundColor(Color.init(red: 217/255, green: 4/255, blue: 41/255))
                    } else {
                        Text("+\(marketStatus.formattedToTwoDecimalPlaces())%")
                            .font(.custom("Ubuntu-Medium", size: 24))
                            .foregroundColor(Color.init(red: 33/255, green: 191/255, blue: 115/255))
                    }
                }
                .padding([.horizontal, .top])
                Text("In the past 24 hours")
                    .font(.custom("Ubuntu-Medium", size: 17))
                    .foregroundColor(Color.init(red: 108/255, green: 117/255, blue: 125/255))
                    .padding(EdgeInsets(top: 1, leading: 16, bottom: 0, trailing: 0))
                
                Text("STOCKS")
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
            .onAppear {
                getMarketStatus()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func getMarketStatus() {
        let marketStatusPercentages = stocksManager.stockPrices.map { $0.preMarketChangePercentage }
        for s in marketStatusPercentages {
            if !s.isNaN {
                marketStatus += s
            }
        }
    }
    
}

#Preview {
    MarketView()
        .environmentObject(StocksManager())
        .environmentObject(PortfolioManager())
}
