import SwiftUI

struct LoadingStocksView: View {
    
    @EnvironmentObject var stocksManager: StocksManager
    
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
            }
            .background(
                Image("loading_back")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LoadingStocksView()
        .environmentObject(StocksManager())
}
