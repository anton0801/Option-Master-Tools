import Foundation

class PortfolioManager: ObservableObject {
    
    @Published var holdings: [HoldingItem] = []
    private let holdingsKey = "holdings"
    
    init() {
        holdings = loadHoldings()
    }
    
    func calculateTotalFundHoldings(stocksManager: StocksManager) -> Double {
        if holdings.isEmpty {
            return 0.0
        }
        var result = 0.0
        for holding in holdings {
            let price = stocksManager.stockPrices.filter { $0.symbol == holding.tiker }[0].preMarket
            result += holding.count * price
        }
        return result
    }
    
    func buyStocks(stocksManager: StocksManager, stockItem: StockItem, money: Double) {
        var holdingItem = holdings.filter { $0.tiker == stockItem.ticker }.first
        var priceStock = stocksManager.stockPrices.filter { $0.symbol == stockItem.ticker }.first
        if let priceStock = priceStock {
            let countOfStocks = money / priceStock.preMarket
            if holdingItem == nil {
                holdings.append(HoldingItem(tiker: stockItem.ticker, count: countOfStocks))
            } else {
                let index = holdings.firstIndex(where: { $0.tiker == stockItem.ticker })!
                holdingItem!.count += countOfStocks
                holdings[index] = holdingItem!
            }
            saveHoldings(holdings)
        }
        
    }
    
    func sellStocks(stocksManager: StocksManager, stockItem: StockItem, money: Double) -> Bool {
        var holdingItem = holdings.filter { $0.tiker == stockItem.ticker }.first
        if holdingItem == nil || holdingItem?.count == 0 {
            return false
        }
        
        if let holdingItemWrapped = holdingItem {
            let priceStock = stocksManager.stockPrices.filter { $0.symbol == stockItem.ticker }.first
            if let priceStock = priceStock {
                if money < priceStock.preMarket {
                    return false
                }
                
                let holdingCount = holdingItemWrapped.count
                let totalMoneyInStock = priceStock.preMarket * holdingCount
                if money > totalMoneyInStock {
                    return false
                }
                let countToSell = money / priceStock.preMarket
                let index = holdings.firstIndex(where: { $0.tiker == stockItem.ticker })!
                holdingItem!.count -= countToSell
                holdings[index] = holdingItem!
                saveHoldings(holdings)
                return true
            }
        }
        return false
    }
    
    func saveHoldings(_ holdings: [HoldingItem]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(holdings) {
            UserDefaults.standard.set(encoded, forKey: holdingsKey)
        }
    }

    func loadHoldings() -> [HoldingItem] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: holdingsKey),
           let holdings = try? decoder.decode([HoldingItem].self, from: data) {
            return holdings
        }
        return []
    }
    
}
