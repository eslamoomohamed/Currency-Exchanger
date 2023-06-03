//
//  ViewModelsHelper.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 03/06/2023.
//

import Foundation

protocol ViewModelsHelper {
    func getCount() -> Int
    func getCellModel(at indexPath: IndexPath) -> TransactionCellModel
}
