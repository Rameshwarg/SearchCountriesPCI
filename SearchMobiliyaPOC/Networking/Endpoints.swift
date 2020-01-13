//
//  Endpoints.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

struct Endpoints {
    private static let baseURL = "https://restcountries.eu/rest/v2/"
    static let name = "\(baseURL)name/"
    static let searchFilter = "?fields=name;flag;population;area;latlng"
}
