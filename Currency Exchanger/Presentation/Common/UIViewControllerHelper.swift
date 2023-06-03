//
//  UIViewControllerHelper.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 03/06/2023.
//

import UIKit

protocol UIViewControllerHelper {
    func setupTableView(tableView: UITableView,
                        cellClass: Swift.AnyClass,
                        delegate: UITableViewDelegate?,
                        dataSource: UITableViewDataSource?)
}

extension UIViewControllerHelper {

    func setupTableView(tableView: UITableView,
                        cellClass: Swift.AnyClass,
                        delegate: UITableViewDelegate? = nil,
                        dataSource: UITableViewDataSource? = nil) {
        tableView.registerCellClassForNib(cellClass: cellClass.self)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

}
