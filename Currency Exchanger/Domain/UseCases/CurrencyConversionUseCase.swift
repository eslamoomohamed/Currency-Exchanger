//
//  CurrencyConversionUseCase.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol CurrencyConversionUseCaseInterface {
    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void)
}

class CurrencyConversionUseCase: CurrencyConversionUseCaseInterface {

    private let currencyConversionRepository: CurrencyConversionRepository


    init(currencyConversionRepository: CurrencyConversionRepository) {
        self.currencyConversionRepository = currencyConversionRepository
    }

    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        currencyConversionRepository.fetchCurrencyConversion(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency, completion: completion)
    }
    
    
}
