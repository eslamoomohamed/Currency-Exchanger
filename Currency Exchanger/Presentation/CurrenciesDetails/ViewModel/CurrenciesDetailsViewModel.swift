//
//  CurrenciesDetailsViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import Foundation

class CurrenciesDetailsViewModel: CurrencyConverter, ViewModelsHelper {

    private let transactions: [TransactionModel]

    init(transactions: [TransactionModel]) {
        let sortedTransactions = transactions.sorted { $0.transactionDate < $1.transactionDate }
        self.transactions = sortedTransactions
    }
}

// MARK: Helpers
extension CurrenciesDetailsViewModel {
    func getCount() -> Int {
        return transactions.count
    }

    func getCellModel(at indexPath: IndexPath) -> TransactionCellModel {
        let transactionModel = transactions[indexPath.row]
        return convertToCellModel(transactionModel)
    }
}
