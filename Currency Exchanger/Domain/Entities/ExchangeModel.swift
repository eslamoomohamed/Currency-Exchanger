//
//  ExchangeModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

struct ExchangeModel: Codable, Equatable {
    let success: Bool
    let timestamp: TimeInterval
    let base: String
    let date: String
    let rates: [String: Double]

    static func == (lhs: ExchangeModel, rhs: ExchangeModel) -> Bool {
        return lhs.success == rhs.success &&
            lhs.timestamp == rhs.timestamp &&
            lhs.base == rhs.base &&
            lhs.date == rhs.date &&
            lhs.rates == rhs.rates
    }
}
