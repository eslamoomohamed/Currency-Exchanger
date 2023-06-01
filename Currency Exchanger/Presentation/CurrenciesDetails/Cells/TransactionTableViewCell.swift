//
//  TransactionTableViewCell.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    static let reuseID = "TransactionTableViewCell"
    
    @IBOutlet weak var fromCurrency: UILabel!
    @IBOutlet weak var toCurrency: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(with cellModel: TransactionCellModel) {
        self.fromCurrency.text = cellModel.exchangeString
        self.toCurrency.text = cellModel.exchangeRateString
        self.amount.text = cellModel.idString
        self.dateLabel.text = cellModel.dateString
    }
}
