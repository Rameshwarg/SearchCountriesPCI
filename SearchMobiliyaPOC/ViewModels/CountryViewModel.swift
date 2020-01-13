//
//  CountryViewModel.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

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
}
