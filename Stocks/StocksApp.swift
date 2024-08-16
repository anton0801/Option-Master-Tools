import SwiftUI

@main
struct StocksApp: App {
    
    @UIApplicationDelegateAdaptor(StocksAppDelegate.self) var stocksDelegate
    @StateObject var stocksManager = StocksManager()
    
    var body: some Scene {
        WindowGroup {
            LoadingStocksView()
                .environmentObject(stocksManager)
        }
    }
}
