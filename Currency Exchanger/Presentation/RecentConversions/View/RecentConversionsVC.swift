//
//  RecentConversionsVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import UIKit

class RecentConversionsVC: UIViewController, StoryboardLoadable {
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var recentConversionsViewModel: RecentConversionsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    

    private func setupTableView() {
        transactionsTableView
            .registerCellClassForNib(cellClass: TransactionTableViewCell.self)
        transactionsTableView.dataSource = self
        transactionsTableView.reloadData()
    }

}

extension RecentConversionsVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return recentConversionsViewModel.transactions.count
    }
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseID) as? TransactionTableViewCell
        
        let transactionModel = recentConversionsViewModel.transactions[indexPath.row]
        let cellModel = CurrenciesDetailsViewModel.convertToCellModel(transactionModel)
        cell?.configureCell(with: cellModel)
        return cell ?? UITableViewCell()
    }
}
