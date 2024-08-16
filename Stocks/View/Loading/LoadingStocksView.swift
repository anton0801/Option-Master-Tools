import SwiftUI

struct LoadingStocksView: View {
    
    @EnvironmentObject var stocksManager: StocksManager
    @StateObject var loadingManager: LoadingStocksManager = LoadingStocksManager()
    
    @State var loadedStocks: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                LottieView(filename: "loading_animation")
                   .frame(width: 200, height: 200)
                
                NavigationLink(destination: NavigatableView()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(stocksManager), isActive: $loadedStocks) {
                    
                }
                
                if !stocksManager.isLoading {
                    Text("")
                        .onAppear {
                            loadedStocks = true
                        }
                }
                
                switch (loadingManager.mythicalActivatedView) {
                    case .fi:
                        Text("")
                            .onAppear {
                                loadedStocks = true
                            }
                        NavigationLink(destination: StocksPreV()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(stocksManager), isActive: $loadedStocks) {
                        }
                    case .se:
                        Text("")
                            .onAppear {
                                stocksManager.fetchStockDetails()
                            }
                    default:
                        EmptyView()
                }
            }
            .background(
                Image("loading_back")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .onReceive(NotificationCenter.default.publisher(for: .ndjsnajdnajbdjbjfsadgsgad), perform: { dasfafsd in
               guard let ndjsandjsa = dasfafsd.userInfo as? [String: Any],
                    let dsadasdfasd = ndjsandjsa["data"] as? [AnyHashable: Any] else {
                  return
              }
                loadingManager.ndjsbajbadsaedhjfads(data: dsadasdfasd)
           })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LoadingStocksView()
        .environmentObject(StocksManager())
}
