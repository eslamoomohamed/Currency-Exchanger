//
//  OtherCurrenciesConverionsVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import UIKit

class OtherCurrenciesConverionsVC: UIViewController, StoryboardLoadable {

    @IBOutlet weak private var transactionsTableView: UITableView!

    var otherCurrenciesConverionsViewModel: OtherCurrenciesConverionsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(otherCurrenciesConverionsViewModel != nil)
        setupTableView()
    }

    private func setupTableView() {
        transactionsTableView
            .registerCellClassForNib(cellClass: TransactionTableViewCell.self)
        transactionsTableView.dataSource = self
        transactionsTableView.reloadData()
    }
}

extension OtherCurrenciesConverionsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return otherCurrenciesConverionsViewModel.transactionsModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusID = TransactionTableViewCell.reuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reusID) as? TransactionTableViewCell

        let transactionModel = otherCurrenciesConverionsViewModel.transactionsModel[indexPath.row]
        let cellModel = OtherCurrenciesConverionsViewModel.convertToCellModel(transactionModel)
        cell?.configureCell(with: cellModel)
        return cell ?? UITableViewCell()
    }
}
