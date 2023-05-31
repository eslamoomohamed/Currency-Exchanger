//
//  CurrencyConversionViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol ICurrencyConversionViewModel {
    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void)
}

class CurrencyConversionViewModel: ICurrencyConversionViewModel {

    private let currencyConversionUseCase: CurrencyConversionUseCase

    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        currencyConversionUseCase.convertCurrency(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency, completion: completion)
    }
    
    init(currencyConversionUseCase: CurrencyConversionUseCase) {
        self.currencyConversionUseCase = currencyConversionUseCase
    }
    
}
