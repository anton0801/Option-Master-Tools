import SwiftUI

struct StocksPreV: View {
    
    @EnvironmentObject var stockManager: StocksManager
    
    private func graphicsStarter() -> String {
        return UserDefaults.standard.string(forKey: .liinkinnninggggsaveeeddd) ?? ""
    }
   
   var body: some View {
       VStack {
           if graphicsStarter().isEmpty {
               dnksjandkasda
           } else {
               nfjkasndkasd
           }
       }
   }
   
   private var nfjkasndkasd: some View {
       MainViewSec()
   }
   
   private var dnksjandkasda: some View {
       NavigatableView()
           .environmentObject(stockManager)
   }
}

#Preview {
    StocksPreV()
        .environmentObject(StocksManager())
}
