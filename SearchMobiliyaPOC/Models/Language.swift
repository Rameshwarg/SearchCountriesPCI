//
//  Language.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

public struct Language: CountryData, Codable {
    public var name: String
    public let iso639_1: String
    
    public init(name: String, iso639_1: String){
        self.name = name
        self.iso639_1 = iso639_1
    }
    
    public static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
        guard let json = json else {
            return nil
        }
        var languages = [Language]()
        
        for data in json {
            if let language = Language(withJson: data) {
                languages.append(language)
            }
        }
        return languages.count > 0 ? languages : nil
    }
}

public extension Language {
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let iso639_1 = json?["iso639_1"] as? String else {
                return nil
        }
        self.name = name
        self.iso639_1 = iso639_1
    }
}
