//
//  CurrencyConversionVC.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import UIKit

class CurrencyConversionVC: UIViewController, StoryboardLoadable {

    var currencyViewModel: CurrencyConversionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(currencyViewModel != nil)
    }

}
