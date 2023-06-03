//
//  OtherCurrenciesConverionsViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import Foundation

class OtherCurrenciesConverionsViewModel: CurrencyConverter, ViewModelsHelper {

    private let transactionsModel: [TransactionModel]!

    init(transactionsModel: [TransactionModel]) {
        self.transactionsModel = transactionsModel
    }

}

// MARK: Helpers
extension OtherCurrenciesConverionsViewModel {
    func getCount() -> Int {
        return transactionsModel.count
    }

    func getCellModel(at indexPath: IndexPath) -> TransactionCellModel {
        let transactionModel = transactionsModel[indexPath.row]
        return convertToCellModel(transactionModel)
    }
}
