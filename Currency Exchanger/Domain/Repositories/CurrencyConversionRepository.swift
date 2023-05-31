//
//  CurrencyConversionRepository.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol CurrencyConversionRepository {
    func fetchCurrencyConversion(amount: Double, fromCurrency: String, toCurrency: String, completion: @escaping (Result<Double, Error>) -> Void)
}
