//
//  LatestRatesAPIRepository.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation
import Combine

class LatestRatesAPIRepository: LatestRatesRepository {

    private let networkDataSource: LatestRatesNetworkDataSource

    init(networkDataSource: LatestRatesNetworkDataSource) {
        self.networkDataSource = networkDataSource
    }

    func fetchLatestRates(baseCurrency: String, symbols: String? = nil) -> AnyPublisher<ExchangeModel, Error> {
        return networkDataSource.fetchLatestRates(baseCurrency: baseCurrency, symbols: symbols)
    }
}
