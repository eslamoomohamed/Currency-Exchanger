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
        let sortedTransactions = transactions.sorted(by: { $0.transactionDate < $1.transactionDate })
        self.transactions = sortedTransactions
    }
    
    static func convertToCellModel(_ transactionModel: TransactionModel) -> TransactionCellModel {
        let dateString = transactionModel.transactionDate.toString(.long)
        let fromCurrencyString = String(format:"%.2f", transactionModel.fromCurrency)
        let toCurrencyString = String(format:"%.2f", transactionModel.toCurrency)
        let exchangeRate = String(format:"%.2f", transactionModel.exchangeRate)
        
        let exchangeString = "\(fromCurrencyString) \(transactionModel.fromCurrencyCode) to Euro \(toCurrencyString) \(transactionModel.toCurrencyCode) to Euro"
        
        let exchangeRateString = "\(transactionModel.amount) \(transactionModel.fromCurrencyCode) = \(exchangeRate) \(transactionModel.toCurrencyCode)"
        
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
