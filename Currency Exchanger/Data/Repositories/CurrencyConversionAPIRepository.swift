//
//  CurrencyConversionAPIRepository.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class CurrencyConversionAPIRepository: CurrencyConversionRepository {
    private let networkDataSource: CurrencyConversionNetworkDataSource

    init(networkDataSource: CurrencyConversionNetworkDataSource) {
        self.networkDataSource = networkDataSource
    }

    func fetchCurrencyConversion(amount: Double,
                                 fromCurrency: Currency,
                                 toCurrency: Currency,
                                 completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        networkDataSource.fetchCurrencyConversion(amount: amount,
                                                  fromCurrency: fromCurrency,
                                                  toCurrency: toCurrency,
                                                  completion: completion)
    }
}
