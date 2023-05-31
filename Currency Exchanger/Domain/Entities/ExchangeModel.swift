//
//  ExchangeModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

struct ExchangeModel: Codable {
    let success: Bool
    let timestamp: TimeInterval
    let base: String
    let date: String
    let rates: [String: Double]
}
