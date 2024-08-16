import Foundation
import WebKit
import Alamofire

extension String {
    static let dbsajdbsajhda = "jbdsjhabdjhadsad"
    static let dbsahdbasjdadh = "dbsahjdbajsbd"
    static let dsadbjsahbdjhasbdjhasbds = "sdnbasjhdbasjdbasd"
    static let sdbsjhabdasbd = "dsdafa"
    static let dsadbhjasda = "dasbjdbasjdhad"
    static let dnasjkfnsjakdnjksad = "dasbjdbasjdhaddbsahjdbasjhdbasjd"
}

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


extension String {
    static let dnasjdknajdnaskdad = "dasjkdnsajkdnjasnda"
    static let dnsakjdnakdnad = "dnsajkfnasjkdnas$"
    static let dnsajknakjsdasd = "9a07d79e-2051-4006-b3e5-298189d9fb9e"
    static let kekektooocococ = "keytoc"
}

func dsadnsajdknas(leglegone: OptionsSecMainGlavR) {
    UserDefaults.standard.set(leglegone.ndsjakndka, forKey: .nadjsnajkcjansd)
    UserDefaults.standard.set(leglegone.ndsjaknda, forKey: .ndjskandkjasndkjasnd)
    UserDefaults.standard.set(leglegone.dnsakjda, forKey: .liinkinnninggggsaveeeddd)
}

func dsandjkasndkasjndjksa() {
    UserDefaults.standard.set(true, forKey: .kekektooocococ)
}

func dnsajknjkfnasncxasnd(leglegone: OptionsSecMainGlavR) {
    dsadnsajdknas(leglegone: leglegone)
    dsandjkasndkasjndjksa()
    UserDefaults.standard.set(false, forKey: .jdsiajdkasndjkasnd)
}

enum MythicClassesView {
    case fi, se, mythicView
}


class StocksObtainerMainer: MainOptionsCalbackableR {
    
    var dnasjdnasjbcasbjdfasd: URL
    
    init(url: URL, valid: OptionChecker, callb: @escaping ([String : Any]?) -> Void) {
        self.dnasjdnasjbcasbjdfasd = url
        self.fndsjandjakfnsagafda = valid
        self.dnasjdbasjda = callb
    }
    
    var fndsjandjakfnsagafda: OptionChecker
    
    var dnasjdbasjda: ([String : Any]?) -> Void
    
    private func dsnajnckasda(d: OptionsMainB?) {
        let h = HTTPHeaders([
            "Content-Type": "application/json",
            "User-Agent": WKWebView().value(forKey: "userAgent") as? String ?? ""
        ])
        self.seasd(d: d, h: h)
    }
    
    private func seasd(d: OptionsMainB?, h: HTTPHeaders) {
        AF.request(dnasjdnasjbcasbjdfasd, method: .post, parameters: d, encoder: JSONParameterEncoder.default, headers: h)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: OptionsSecMainGlavR.self) { response in
                
                switch response.result {
                case .success(let value):
                    let validationRes = self.fndsjandjakfnsagafda.returnIfValid(validDat: value)
                    if validationRes {
                        self.dnasjdbasjda(["rData": value])
                    } else {
                        self.dnasjdbasjda(["e": "sag"])
                    }
                case .failure(_):
                    self.dnasjdbasjda(nil)
                }
            }
    }
    
    func obtainstocksdatadetails(params: [String : Any]) {
        dsnajnckasda(d: params["data"] as? OptionsMainB)
    }
    
    
    
}
