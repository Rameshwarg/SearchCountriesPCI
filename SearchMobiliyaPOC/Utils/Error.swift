//
//  Error.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

public enum RequestError: Error {
    case badFormatURL
    case noResponse
    case invalidResponse
    case invalidData
}
