//
//  CurrencyConversionViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol ICurrencyConversionViewModel {
    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void)
    func getLatestRates(baseCurrency: String, symbols: String?, completion: @escaping (Result<ExchangeModel, Error>) -> Void)
}

class CurrencyConversionViewModel: ICurrencyConversionViewModel {

    private let currencyConversionUseCase: CurrencyConversionUseCaseInterface
    private let latestRatesUseCase: LatestRateUseCaseInterface

    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        currencyConversionUseCase.convertCurrency(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency, completion: completion)
    }
    
    init(currencyConversionUseCase: CurrencyConversionUseCaseInterface, latestRatesUseCase: LatestRateUseCaseInterface) {
        self.currencyConversionUseCase = currencyConversionUseCase
        self.latestRatesUseCase = latestRatesUseCase
    }

    func getLatestRates(baseCurrency: String, symbols: String? = nil, completion: @escaping (Result<ExchangeModel, Error>) -> Void) {
        latestRatesUseCase.fetchLatestRates(baseCurrency: baseCurrency, symbols: symbols, completion: completion)
    }
    
}
