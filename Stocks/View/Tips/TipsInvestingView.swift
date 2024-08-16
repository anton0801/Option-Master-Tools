import SwiftUI

struct TipsInvestingView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Basic tips")
                        .font(.custom("Ubuntu-Bold", size: 24))
                        .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                        .padding()
                
                    ForEach(guides, id: \.id) { guide in
                        NavigationLink(destination: TipsDetailsView(guide: guide)
                            .navigationBarBackButtonHidden(true)) {
                                VStack {
                                    Image(guide.image)
                                        .resizable()
                                        .frame(width: 350, height: 200)
                                        .scaledToFit()
                                        .cornerRadius(16)
                                    
                                    Text(guide.title)
                                        .font(.custom("Ubuntu-Medium", size: 20))
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 2)
                                        .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                                }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    TipsInvestingView()
}
