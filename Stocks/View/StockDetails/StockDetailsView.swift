import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct TradingViewChart: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let viewConfiguration = WKWebpagePreferences()
        viewConfiguration.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = viewConfiguration
        // configuration.preferences.javaScriptEnabled = true
        let view = WKWebView(frame: .zero, configuration: configuration)
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}


struct StockDetailsView: View {
    
    var stockItem: StockItem
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var stocksManager: StocksManager
    @EnvironmentObject var portfolioManager: PortfolioManager
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        presMode.wrappedValue.dismiss()
                    } label: {
                        Image("arrow_back")
                            .resizable()
                            .frame(width: 14, height: 24)
                    }
                    
                    WebImage(url: URL(string: "\(stockItem.branding.iconUrl)?apiKey=\(String.apiKey)"))
                        .resizable()
                        .frame(width: 42, height: 42)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(52)
                        .padding(.leading)
                    Text(stockItem.name)
                        .font(.custom("Ubuntu-Bold", size: 16))
                        .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                        .padding(.leading, 4)
                    
                    Spacer()
                }
                .padding()
                
                let openClosePrices = stocksManager.stockPrices.filter { $0.symbol == stockItem.ticker }[0]
//                let openClosePrices = OpenCloseResponse(symbol: "MSFT", open: 243.21, high: 246.213, low: 242.123, volume: 2132413, preMarket: 245.12)
                HStack {
                    Text("$\(openClosePrices.preMarket.formattedToTwoDecimalPlaces())")
                        .font(.custom("Ubuntu-Bold", size: 18))
                        .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    if openClosePrices.preMarketChangePercentage > 0 {
                        Text("+\(openClosePrices.preMarketChangePercentage.formattedToTwoDecimalPlaces())%")
                            .font(.custom("Ubuntu-Medium", size: 13))
                            .padding(.top, 2)
                            .foregroundColor(Color.init(red: 33/255, green: 191/255, blue: 115/255))
                    } else {
                        Text("\(openClosePrices.preMarketChangePercentage.formattedToTwoDecimalPlaces())%")
                            .font(.custom("Ubuntu-Medium", size: 13))
                            .padding(.top, 2)
                            .foregroundColor(Color.init(red: 217/255, green: 4/255, blue: 41/255))
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                TradingViewChart(htmlContent: chartData)
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .padding(.top)
                
                HStack {
                    WebImage(url: URL(string: "\(stockItem.branding.iconUrl)?apiKey=\(String.apiKey)"))
                        .resizable()
                        .frame(width: 52, height: 52)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(52)
                    VStack(alignment: .leading) {
                        Text(stockItem.name)
                            .font(.custom("Ubuntu-Bold", size: 16))
                            .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                            .padding(.leading, 4)
                        
                        Text("\((portfolioManager.holdings.filter { $0.tiker == stockItem.ticker }.first?.count ?? 0.0).formattedToTwoDecimalPlaces()) stocks")
                            .font(.custom("Ubuntu-Bold", size: 14))
                            .foregroundColor(Color.init(red: 108/255, green: 117/255, blue: 125/255))
                            .padding(.leading, 4)
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
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
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: BuySellView(type: .buy, stockItem: stockItem)
                        .environmentObject(stocksManager)
                        .environmentObject(portfolioManager)
                        .navigationBarBackButtonHidden(true)) {
                        Text("BUY")
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
                    }
                    Spacer()
                    NavigationLink(destination: BuySellView(type: .sell, stockItem: stockItem)
                        .environmentObject(stocksManager)
                        .environmentObject(portfolioManager)
                        .navigationBarBackButtonHidden(true)) {
                        Text("SELL")
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .font(.custom("Ubuntu-Medium", size: 16))
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                                    .fill(
                                        Color.init(red: 68/255, green: 62/255, blue: 244/255)
                                    )
                                    .frame(width: .infinity, height: 50)
                            )
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var chartData: String {
        get {
            return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8">
            <title>TradingView Chart</title>
        </head>
        <body>
            <!-- TradingView Widget BEGIN -->
            <div class="tradingview-widget-container">
                <div id="tradingview_chart"></div>
                <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
                <script type="text/javascript">
                new TradingView.widget({
                  "width": 800,
                  "height": 600,
                  "symbol": "NASDAQ:\(stockItem.ticker)",
                  "interval": "D",
                  "timezone": "Etc/UTC",
                  "theme": "light",
                  "style": "2",
                  "locale": "en",
                  "toolbar_bg": "#0063F5",
                  "hide_side_toolbar": true,
                  "allow_symbol_change": false,
                  "hide_top_toolbar": true,
                  "hide_legend": true,
                  "studies": [],
                  "container_id": "tradingview_chart"
                });
                </script>
            </div>
            <!-- TradingView Widget END -->
        </body>
        </html>
        """
        }
    }
    
}

#Preview {
    StockDetailsView(stockItem: StockItem(ticker: "MSFT", name: "Microsoft Corp", market: "stocks", locale: "us", primaryExchange: "XNAS", type: "CS", marketCap: 3098230993286.8403, phoneNumber: "425-882-8080", description: "Microsoft develops and licenses consumer and enterprise software. It is known for its Windows operating systems and Office productivity suite. The company is organized into three equally sized broad segments: productivity and business processes (legacy Microsoft Office, cloud-based Office 365, Exchange, SharePoint, Skype, LinkedIn, Dynamics), intelligence cloud (infrastructure- and platform-as-a-service offerings Azure, Windows Server OS, SQL Server), and more personal computing (Windows Client, Xbox, Bing search, display advertising, and Surface laptops, tablets, and desktops).", homepageUrl: "https://www.microsoft.com", branding: StockBranding(logoUrl: "https://api.polygon.io/v1/reference/company-branding/bWljcm9zb2Z0LmNvbQ/images/2024-08-01_logo.svg", iconUrl: "https://api.polygon.io/v1/reference/company-branding/bWljcm9zb2Z0LmNvbQ/images/2024-08-01_icon.jpeg")))
        .environmentObject(StocksManager())
        .environmentObject(PortfolioManager())
}
