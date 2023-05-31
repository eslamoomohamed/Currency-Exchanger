//
//  RepositoryAssembler.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class RepositoryAssembler {
    private let networkService: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
    
    func assembleCurrencyConversionRepository() -> CurrencyConversionRepository {
        let networkDataSource = CurrencyConversionAPIDataSource(networkService: networkService)
        return CurrencyConversionAPIRepository(networkDataSource: networkDataSource)
    }

    func assembleLatestRatesRepository() -> LatestRatesRepository {
        let networkDataSource = LatestRatesApiDataSource(networkService: networkService)
        return LatestRatesAPIRepository(networkDataSource: networkDataSource)
    }
}
