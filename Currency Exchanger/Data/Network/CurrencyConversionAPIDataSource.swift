//
//  CurrencyConversionAPIDataSource.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol CurrencyConversionNetworkDataSource {
    func fetchCurrencyConversion(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void)
}

class CurrencyConversionAPIDataSource: CurrencyConversionNetworkDataSource {

    func fetchCurrencyConversion(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
    }
}
