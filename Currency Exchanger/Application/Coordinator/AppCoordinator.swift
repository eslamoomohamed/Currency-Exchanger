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
        let currencyVC = CurrencyConversionVC()
        router.setRootViewController(currencyVC, hideBar: true)
    }
}
