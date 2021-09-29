import Foundation

struct FinanceModel: Decodable {
    let by: String
    let validKey: Bool
    let results: ResultsFinance
    let executionTime: Int
    let fromCache: Bool
    
    enum CodingKeys: String, CodingKey {
        case by
        case validKey = "valid_key"
        case results
        case executionTime = "execution_time"
        case fromCache = "from_cache"
        
    }
    
}

struct ResultsFinance: Decodable {
    
    let currencies: Currencies
    let stocks: Stocks
    let availableSources: [String]
    let taxes: [String]
    
    enum CodingKeys: String, CodingKey {
        case currencies
        case stocks
        case availableSources = "available_sources"
        case taxes
        
    }
    
}

// MARK: - Currencies

struct Currencies: Codable {
    
    let source: String
    let usd, eur, gbp, ars: Ars
    let cad, aud, jpy, cny: Ars
    let btc: Ars
    
    enum CodingKeys: String, CodingKey {
        case source
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
        case ars = "ARS"
        case cad = "CAD"
        case aud = "AUD"
        case jpy = "JPY"
        case cny = "CNY"
        case btc = "BTC"
        
    }
    
}

struct Ars: Codable {
    let name: String
    let buy: Double
    let sell: Double?
    let variation: Double
    
}

struct Stocks: Codable {
    let ibovespa, ifix, nasdaq, dowjones: Cac
    let cac, nikkei: Cac
    
    enum CodingKeys: String, CodingKey {
        case ibovespa = "IBOVESPA"
        case ifix = "IFIX"
        case nasdaq = "NASDAQ"
        case dowjones = "DOWJONES"
        case cac = "CAC"
        case nikkei = "NIKKEI"
        
    }
    
}

struct Cac: Codable {
    let name, location: String
    let points, variation: Double
    
}
