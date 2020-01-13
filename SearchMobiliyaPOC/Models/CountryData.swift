//
//  CountryDataModel.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit

public struct CountryDataModel: Codable {
    public var countryName: String
    public var areaSize: Double?
    public var flag: String?
    public var capital: String?
    public var region: String?
    public var subregion:String?
    public var callingCode:String?
    public var timeZone:String?
    public var regionalBlocks: [RegionalBlock]?
    public var language:String?
    public var currency:String?
    public var imageData:Data?
    
    public init(name: String, population: Int, areaSize: Double?, flag: String?, capital: String?, region: String?,subregion: String?,timeZone:String?,callingCode:String?,image:Data?) {
        self.countryName = name
        self.areaSize = areaSize
        self.flag = flag
        self.capital = capital
        self.region = region
        self.subregion = subregion
        self.timeZone = timeZone
        self.callingCode = callingCode
        self.imageData = image
    }
}

public extension CountryDataModel {
    init?(withJson json: [String : Any]?) {
       
        self.countryName = json?["name"] as? String ?? ""
        self.areaSize = json?["area"] as? Double
        self.flag = json?["flag"] as? String
        self.capital = json?["capital"] as? String
        self.region = json?["region"] as? String
        self.subregion = json?["subregion"] as? String
        self.timeZone = json?["region"] as? String
        let callingCode = json?["numericCode"] as? [String]
        self.callingCode = callingCode?.first
        self.imageData = nil
        let language = json?["languages"] as? [[String: Any]]
        self.language = language?.first?["name"] as? String
        let currency = json?["currencies"] as? [[String: Any]]
        self.currency = currency?.first?["name"] as? String
        
        self.regionalBlocks = RegionalBlock.getCountryData(json: json?["regionalBlocs"] as? [[String: Any]]) as? [RegionalBlock]
    }

}
