//
//  CurrenciesDetailsViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import Foundation

class CurrenciesDetailsViewModel {

    let transactions: [TransactionModel]

    init(transactions: [TransactionModel]) {
        let sortedTransactions = transactions.sorted { $0.transactionDate < $1.transactionDate }
        self.transactions = sortedTransactions
    }

    static func convertToCellModel(_ transactionModel: TransactionModel) -> TransactionCellModel {
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

    func numberOfsections() -> Int {
        let uniqueAttributes = Set(transactions.map { $0.transactionDate })
        return uniqueAttributes.count
    }
}
