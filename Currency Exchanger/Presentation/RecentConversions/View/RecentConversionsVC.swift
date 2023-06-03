//
//  RecentConversionsVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 02/06/2023.
//

import UIKit

class RecentConversionsVC: UIViewController, StoryboardLoadable, UIViewControllerHelper {
    @IBOutlet weak private var transactionsTableView: UITableView!

    var recentConversionsViewModel: RecentConversionsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(recentConversionsViewModel != nil)
        setupTableView(tableView: transactionsTableView,
                       cellClass: TransactionTableViewCell.self,
                       dataSource: self)
    }

}

// MARK: TableView DataSource
extension RecentConversionsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return recentConversionsViewModel.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = TransactionTableViewCell.reuseID
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as? TransactionTableViewCell

        cell?.configureCell(with: recentConversionsViewModel.getCellModel(at: indexPath))
        return cell ?? UITableViewCell()
    }
}
