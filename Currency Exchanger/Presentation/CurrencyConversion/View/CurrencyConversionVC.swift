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
        currencyViewModel.getLatestRates(baseCurrency: FixerIoApiConstants.baseCurrency) { result in
            switch result {
            case .success(let success):
                print(success.rates)
            case .failure(let failure):
                print(failure)
            }
        }
    }

}
