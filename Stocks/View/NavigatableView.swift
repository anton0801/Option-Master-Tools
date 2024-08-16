import SwiftUI

struct NavigatableView: View {
    
    @EnvironmentObject var stocksManager: StocksManager
    @StateObject var portfolioManager = PortfolioManager()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView(selectedTab: $selectedTab)
                .environmentObject(portfolioManager)
                .environmentObject(stocksManager)
                .tabItem {
                    VStack {
                        if selectedTab == 0 {
                            Image("home_active")
                            
                        } else {
                            Image("home")
                        }
                    }
                }
                .tag(0)
            
            PortfolioView(selectedTab: $selectedTab)
                .environmentObject(portfolioManager)
                .environmentObject(stocksManager)
                .tabItem {
                    if selectedTab == 1 {
                        Image("portfolio_active")
                    } else {
                        Image("portfolio")
                    }
                }
                .tag(1)
            
            MarketView()
                .environmentObject(stocksManager)
                .environmentObject(portfolioManager)
                .tabItem {
                    if selectedTab == 2 {
                        Image("market_active")
                    } else {
                        Image("market")
                    }
                }
                .tag(2)
            
            ProfileView()
                .environmentObject(stocksManager)
                .environmentObject(portfolioManager)
                .tabItem {
                    if selectedTab == 3 {
                        Image("profile_active")
                    } else {
                        Image("profile")
                    }
                }
                .tag(3)
            
            TipsInvestingView()
                .tabItem {
                    if selectedTab == 4 {
                        Image("tips_icon_active")
                    } else {
                        Image("tips_icon")
                    }
                    Text("Tips")
                }
                .tag(4)
        }
    }
}

#Preview {
    NavigatableView()
        .environmentObject(StocksManager())
}
