//
//  LatestRatesRequest.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

struct LatestRatesRequest: Request {
    let accessKey: String
    let baseCurrency: String
    let symbols: String?

    var path: String {
        return "latest"
    }

    var parameters: RequestParams {
        var params: [String: Any] = [
            "access_key": accessKey,
            "base": baseCurrency
        ]

        if let symbols = symbols {
            params["symbols"] = symbols
        }

        return .url(params)
    }
}
