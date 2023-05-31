//
//  UseCasesAssembler.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class UseCasesAssembler {

    private let repositoryAssembler: RepositoryAssembler
    
    init(repositoryAssembler: RepositoryAssembler) {
        self.repositoryAssembler = repositoryAssembler
    }
    
    func assembleCurrencyConversionUseCase() -> CurrencyConversionUseCaseInterface {
        let currencyConversionRepository = repositoryAssembler.assembleCurrencyConversionRepository()
        return CurrencyConversionUseCase(currencyConversionRepository: currencyConversionRepository)
    }

    func assembleLatestRateUseCase() -> LatestRateUseCase {
        let latestRateUseCase = repositoryAssembler.assembleLatestRatesRepository()
        return LatestRateUseCase(latestRatesRepository: latestRateUseCase)
    }
}
