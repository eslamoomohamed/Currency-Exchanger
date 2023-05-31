//
//  CurrencyConversionUseCase.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

    protocol CurrencyConversionUseCaseInterface {
        func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency) -> Double
    }

    class CurrencyConversionUseCase: CurrencyConversionUseCaseInterface {
        
        func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency) -> Double {
            return 0
        }
        
        
    }
