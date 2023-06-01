//
//  LatestRatesUseCase.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation
import Combine

protocol LatestRateUseCaseInterface {
    func fetchLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error>
}

class LatestRateUseCase: LatestRateUseCaseInterface {

    private let latestRatesRepository: LatestRatesRepository

    init(latestRatesRepository: LatestRatesRepository) {
        self.latestRatesRepository = latestRatesRepository
    }

    func fetchLatestRates(baseCurrency: String, symbols: String? = nil) -> AnyPublisher<ExchangeModel, Error> {
        return latestRatesRepository.fetchLatestRates(baseCurrency: baseCurrency, symbols: symbols)
    }
}
