//
//  LatestRatesAPIRepository.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class LatestRatesAPIRepository: LatestRatesRepository {

    private let networkDataSource: LatestRatesNetworkDataSource

    init(networkDataSource: LatestRatesNetworkDataSource) {
        self.networkDataSource = networkDataSource
    }

    func fetchLatestRates(baseCurrency: String, completion: @escaping (Result<ExchangeModel, Error>) -> Void) {
        networkDataSource.fetchLatestRates(baseCurrency: baseCurrency, completion: completion)
    }
}
