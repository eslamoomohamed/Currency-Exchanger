//
//  TransactionModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import Foundation

struct TransactionModel {
    let id: Int
    let transactionId: String
    let transactionDate: Date
    let fromCurrencyCode: String
    let fromCurrency: Double
    let toCurrencyCode: String
    let toCurrency: Double
    let exchangeRate: Double
    let amount: Double

    init(id: Int,
         transactionId: String,
         transactionDate: Date,
         fromCurrencyCode: String,
         fromCurrency: Double,
         toCurrencyCode: String,
         toCurrency: Double,
         exchangeRate: Double,
         amount: Double) {
        self.id = id
        self.transactionId = transactionId
        self.transactionDate = transactionDate
        self.fromCurrency = fromCurrency
        self.fromCurrencyCode = fromCurrencyCode
        self.toCurrencyCode = toCurrencyCode
        self.toCurrency = toCurrency
        self.exchangeRate = exchangeRate
        self.amount = amount
    }
    init(transactionObject: TransactionObject) {
        self.id = transactionObject.id
        self.transactionId = transactionObject.transactionId
        self.transactionDate = transactionObject.transactionDate
        self.fromCurrency = transactionObject.fromCurrency
        self.fromCurrencyCode = transactionObject.fromCurrencyCode
        self.toCurrencyCode = transactionObject.toCurrencyCode
        self.toCurrency = transactionObject.toCurrency
        self.exchangeRate = transactionObject.exchangeRate
        self.amount = transactionObject.amount
    }
}
