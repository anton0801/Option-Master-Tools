import SwiftUI

struct TipsDetailsView: View {
    
    @Environment(\.presentationMode) var pr
    var guide: InvestmentGuide
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Button {
                        pr.wrappedValue.dismiss()
                    } label: {
                        Image("arrow_back")
                            .resizable()
                            .frame(width: 12, height: 20)
                    }
                    Spacer()
                                                        
                    Text(guide.title)
                        .font(.custom("Ubuntu-Bold", size: 20))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Image(guide.image)
                    .resizable()
                    .frame(width: 350, height: 250)
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding()
                
                Text(guide.steps.joined(separator: "\n\n"))
                    .font(.custom("Ubuntu-Medium", size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.init(red: 33/255, green: 37/255, blue: 41/255))
                    .padding(.horizontal)
              
            }
        }
    }
}

#Preview {
    TipsDetailsView(guide: InvestmentGuide(
        image: "guide_1",
        title: "Basics of Proper Stock Investing",
        steps: [
            "Long-Term Approach: Plan your investments for several years, preferably decades.",
            "Portfolio Diversification: Spread your capital across different sectors and countries.",
            "Regular Investments: Invest regularly, such as monthly, regardless of market conditions.",
            "Financial Metrics Analysis: Study a company's revenue, net profit, profitability, and debt load.",
            "Risk Assessment: Evaluate whether you can handle temporary drops in asset value."
        ]
    ))
}
