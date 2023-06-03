//
//  CurrencyConverter.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import Foundation

protocol CurrencyConverter {
    func convertToCellModel(_ transactionModel: TransactionModel) -> TransactionCellModel
}

extension CurrencyConverter {

    func convertToCellModel(_ transactionModel: TransactionModel) -> TransactionCellModel {
        let dateString = transactionModel.transactionDate.toString(.long)
        let fromCurrencyString = String(format: "%.2f", transactionModel.fromCurrency)
        let toCurrencyString = String(format: "%.2f", transactionModel.toCurrency)
        let exchangeRate = String(format: "%.2f", transactionModel.exchangeRate)

        let exchangeString1 = "\(fromCurrencyString) \(transactionModel.fromCurrencyCode)"
        let exchangeString2 = "\(toCurrencyString) \(transactionModel.toCurrencyCode)"
        let exchangeString = "\(exchangeString1) to Euro \(exchangeString2) to Euro"

        let exchangeRateString1 = "\(transactionModel.amount) \(transactionModel.fromCurrencyCode)"
        let exchangeRateString2 = "\(exchangeRate) \(transactionModel.toCurrencyCode)"
        let exchangeRateString = "\(exchangeRateString1) = \(exchangeRateString2)"

        return TransactionCellModel(idString: transactionModel.transactionId,
            dateString: dateString,
            exchangeString: exchangeString,
            exchangeRateString: exchangeRateString)
    }
}
