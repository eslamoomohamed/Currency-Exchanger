//
//  TableViewHelper.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import UIKit

extension UITableView {
    public func registerCellClassForNib(cellClass: Swift.AnyClass) {
        let identifier = "\(cellClass)"
        self.register(UINib(nibName: identifier,
                            bundle: Bundle(for: cellClass)),
                      forCellReuseIdentifier: identifier)
    }
}
