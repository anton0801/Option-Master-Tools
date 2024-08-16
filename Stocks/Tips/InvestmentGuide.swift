import Foundation

struct InvestmentGuide: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let steps: [String]
}

let guides = [
    InvestmentGuide(
        image: "guide_1",
        title: "Basics of Proper Stock Investing",
        steps: [
            "Long-Term Approach: Plan your investments for several years, preferably decades.",
            "Portfolio Diversification: Spread your capital across different sectors and countries.",
            "Regular Investments: Invest regularly, such as monthly, regardless of market conditions.",
            "Financial Metrics Analysis: Study a company's revenue, net profit, profitability, and debt load.",
            "Risk Assessment: Evaluate whether you can handle temporary drops in asset value."
        ]
    ),
    InvestmentGuide(
        image: "guide_2",
        title: "How to Find Promising Stocks to Grow Your Capital",
        steps: [
            "Market and Trend Research: Monitor market trends and promising industries.",
            "Company Growth Potential Evaluation: Focus on companies showing steady revenue and profit growth.",
            "Insider Information and Analyst Reports: Follow professional analysts' opinions and insider information.",
            "Comparative Analysis: Analyze P/E, P/B ratios, and dividend yield.",
            "Personal Beliefs and Convictions: Invest in companies whose business you understand."
        ]
    ),
    InvestmentGuide(
        image: "guide_3",
        title: "How to Manage a Stock Portfolio",
        steps: [
            "Regular Portfolio Review: Rebalance your portfolio to maintain an optimal risk-return ratio.",
            "Risk Management: Set stop-loss orders to protect your capital from large losses.",
            "Portfolio Rebalancing: Reallocate assets according to market changes and your strategy.",
            "Dividend Reinvestment: Consider reinvesting dividends to purchase more stocks."
        ]
    ),
    InvestmentGuide(
        image: "guide_4",
        title: "Mistakes to Avoid When Investing in Stocks",
        steps: [
            "Panic Selling During Market Declines: Don't sell stocks due to short-term market drops.",
            "Neglecting Diversification: Always diversify your portfolio to reduce risk.",
            "Lack of a Clear Strategy: Define your goals, investment horizon, and risk tolerance.",
            "Overconfidence in Forecasts: Evaluate all possible scenarios and don't overestimate your predictive abilities."
        ]
    )
]

