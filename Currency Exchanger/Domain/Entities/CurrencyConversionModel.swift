//
//  CurrencyConversionModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

struct CurrencyConversionModel: Codable {
    let success: Bool
    let query: ConversionQuery
    let info: ConversionInfo
    let historical: String?
    let date: String
    let result: Double
}

struct ConversionQuery: Codable {
    let from: String
    let to: String
    let amount: Double
}

struct ConversionInfo: Codable {
    let timestamp: TimeInterval
    let rate: Double
}
