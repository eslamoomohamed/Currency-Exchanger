//
//  BaseCoordinator.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import UIKit

class BaseCoordinator: CoordinatorType {
    private(set) var childCoordinators: [CoordinatorType] = []
    let router: RouterType

    init(router: RouterType) {
        self.router = router
    }

    func start() {
        start()
    }

    func toPresent() -> UIViewController {
        return router.toPresent()
    }

}
