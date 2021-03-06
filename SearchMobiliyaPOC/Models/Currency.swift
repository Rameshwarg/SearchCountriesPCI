//
//  Currency.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

public struct Currency: CountryData, Codable {
    public var name: String
    public let symbol: String
    
    public init(name: String, symbol: String){
        self.name = name
        self.symbol = symbol
    }
    
    public static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
        guard let json = json else {
            return nil
        }
        var currencies = [Currency]()
        
        for data in json {
            if let currency = Currency(withJson: data) {
                currencies.append(currency)
            }
        }
        return currencies.count > 0 ? currencies : nil
    }
}

public extension Currency {
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let symbol = json?["symbol"] as? String else {
                return nil
        }
        self.name = name
        self.symbol = symbol
    }
}
