//
//  OtherCurrenciesConverionsVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import UIKit

class OtherCurrenciesConverionsVC: UIViewController, StoryboardLoadable, UIViewControllerHelper {

    @IBOutlet weak private var transactionsTableView: UITableView!

    var otherCurrenciesConverionsViewModel: OtherCurrenciesConverionsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(otherCurrenciesConverionsViewModel != nil)
        setupTableView(tableView: transactionsTableView,
                       cellClass: TransactionTableViewCell.self,
                       dataSource: self)
    }
}

// MARK: TableView DataSource
extension OtherCurrenciesConverionsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return otherCurrenciesConverionsViewModel.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusID = TransactionTableViewCell.reuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reusID) as? TransactionTableViewCell

        cell?.configureCell(with: otherCurrenciesConverionsViewModel.getCellModel(at: indexPath))
        return cell ?? UITableViewCell()
    }
}
