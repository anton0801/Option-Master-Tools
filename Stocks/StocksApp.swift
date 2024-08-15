import SwiftUI

@main
struct StocksApp: App {
    
    @StateObject var stocksManager = StocksManager()
    
    var body: some Scene {
        WindowGroup {
            LoadingStocksView()
                .environmentObject(stocksManager)
                .onAppear {
                    stocksManager.fetchStockDetails()
                }
        }
    }
}
