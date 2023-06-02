//
//  CurrencyConversionRequest.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

struct CurrencyConversionRequest: Request {
    let accessKey: String
    let fromCurrency: String
    let toCurrency: String
    let amount: Double
    let date: String?

    var path: String {
        return "convert"
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: RequestParams {
        let params: [String: Any] = [
            "access_key": accessKey,
            "from": fromCurrency,
            "to": toCurrency,
            "amount": String(amount)
        ]

        return .url(params)
    }

}
