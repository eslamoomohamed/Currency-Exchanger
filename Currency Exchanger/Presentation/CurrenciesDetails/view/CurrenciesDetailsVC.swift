//
//  CurrenciesDetailsVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import UIKit

class CurrenciesDetailsVC: UIViewController, StoryboardLoadable {

    @IBOutlet private weak var transactionsTableView: UITableView!
    var currenciesDetailsViewModel: CurrenciesDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(currenciesDetailsViewModel != nil)
        print(currenciesDetailsViewModel.transactions)
        setupTableView()
    }

    private func setupTableView() {
        transactionsTableView
            .registerCellClassForNib(cellClass: TransactionTableViewCell.self)
        transactionsTableView.dataSource = self
        transactionsTableView.reloadData()
    }
}

extension CurrenciesDetailsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return currenciesDetailsViewModel.transactions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = TransactionTableViewCell.reuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as? TransactionTableViewCell

        let transactionModel = currenciesDetailsViewModel.transactions[indexPath.row]
        let cellModel = CurrenciesDetailsViewModel.convertToCellModel(transactionModel)
        cell?.configureCell(with: cellModel)
        return cell ?? UITableViewCell()
    }
}
