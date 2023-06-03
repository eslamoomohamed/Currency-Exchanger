//
//  CurrenciesDetailsVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import UIKit

class CurrenciesDetailsVC: UIViewController, StoryboardLoadable, UIViewControllerHelper {

    @IBOutlet private weak var transactionsTableView: UITableView!
    var currenciesDetailsViewModel: CurrenciesDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(currenciesDetailsViewModel != nil)
        setupTableView(tableView: transactionsTableView,
                       cellClass: TransactionTableViewCell.self,
                       dataSource: self)
    }
}

// MARK: TableView DataSource
extension CurrenciesDetailsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return currenciesDetailsViewModel.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = TransactionTableViewCell.reuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as? TransactionTableViewCell

        cell?.configureCell(with: currenciesDetailsViewModel.getCellModel(at: indexPath))
        return cell ?? UITableViewCell()
    }
}
