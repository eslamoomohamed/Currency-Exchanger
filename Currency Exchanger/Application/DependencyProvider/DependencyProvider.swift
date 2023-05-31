//
//  DependencyProvider.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class DependencyProvider {

    let networkService: NetworkService
    let currencyConversionAPIDataSource: CurrencyConversionNetworkDataSource
    let latestRatesNetworkDataSource: LatestRatesNetworkDataSource

    init() {
        networkService = NetworkService(session: URLSession.shared)
        currencyConversionAPIDataSource = CurrencyConversionAPIDataSource(networkService: networkService)
        latestRatesNetworkDataSource = LatestRatesApiDataSource(networkService: networkService)
    }

}
