//
//  LatestRatesUseCase.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol LatestRateUseCaseInterface {
    func fetchLatestRates(baseCurrency: String, completion: @escaping (Result<ExchangeModel, Error>) -> Void)
}

class LatestRateUseCase: LatestRateUseCaseInterface {

    private let latestRatesRepository: LatestRatesRepository

    init(latestRatesRepository: LatestRatesRepository) {
        self.latestRatesRepository = latestRatesRepository
    }

    func fetchLatestRates(baseCurrency: String, completion: @escaping (Result<ExchangeModel, Error>) -> Void) {
        latestRatesRepository.fetchLatestRates(baseCurrency: baseCurrency, completion: completion)
    }
}
