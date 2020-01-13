//
//  CountryViewModel.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit

public protocol CountryViewModelDelegate: AnyObject {
    func didReceiveCountries(countries: [CountryDataModel])
    func didFailDownloadCountries(error: Error)
}

public class CountryViewModel {
    
    public weak var delegate: CountryViewModelDelegate?
    private var service: Service?
    
    public init(service: Service = Service()) {
        self.service = service
    }
        
    public func requestCountriesByName(countryName: String) {
        service?.requestCountryByName(countryName: countryName, completion: completionBlock)
    }
    
    private func completionBlock(result: [CountryDataModel]?, error: Error?) {
        unowned let unownedSelf = self
        guard let result = result else {
            if let error = error {
                unownedSelf.delegate?.didFailDownloadCountries(error: error)
            }
            return
        }
        unownedSelf.delegate?.didReceiveCountries(countries: result)
    }
    
    func searchDataInLocalDB(text:String) -> [CountryDataModel]? {
        let result = DataBaseOperation.shared.retrieveCountryData()
        let resultPredicate = NSPredicate(format: "self contains[cd] %@", text)
        let filtered = result?.filter {
            resultPredicate.evaluate(with: $0.countryName.replacingOccurrences(of: " ", with: ""))
        }
        return filtered
    }
    
}
