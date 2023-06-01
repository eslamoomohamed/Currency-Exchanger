//
//  AppCoordinator.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    
    private let dependencyProvider: DependencyProvider
    override init(router: RouterType) {
        self.dependencyProvider = DependencyProvider()
        super.init(router: router)
    }

    override func start() {
        showCurrencyVC()
    }
}

extension AppCoordinator {
    
    func showCurrencyVC() {
        let currencyVC = CurrencyConversionVC.loadFromStoryboard()
        currencyVC.currencyViewModel = CurrencyConversionViewModel(currencyConversionUseCase: dependencyProvider.useCasesAssembler.assembleCurrencyConversionUseCase(),
                                                                             latestRatesUseCase: dependencyProvider.useCasesAssembler.assembleLatestRateUseCase())
        currencyVC.shouldShowDetailsScreen = { [weak self] in
            self?.showCurrenciesDetailsVC()
        }
        router.setRootViewController(currencyVC, hideBar: false)
    }

    func showCurrenciesDetailsVC() {
        let currencyDetailsVC = CurrenciesDetailsVC.loadFromStoryboard()
        router.push(currencyDetailsVC, animated: true, completion: nil)
    }
}
