//
//  OtherCurrenciesConverionsViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import Foundation
import Combine

class OtherCurrenciesConverionsViewModel {
    
    let transactionsModel: [TransactionModel]!
    
    init(transactionsModel: [TransactionModel]) {
        self.transactionsModel = transactionsModel
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
    
}
