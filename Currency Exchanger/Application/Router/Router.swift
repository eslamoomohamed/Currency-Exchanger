//
//  Router.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import UIKit

class Router: NSObject, RouterType, UINavigationControllerDelegate {
    private var completions: [UIViewController: () -> Void]

    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }

    let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        self.navigationController.delegate = self
    }

    func present(_ module: UIViewController, animated: Bool = true, presentationStyle: UIModalPresentationStyle) {
        let presentedController = module
        presentedController.modalPresentationStyle = presentationStyle
        navigationController.present(presentedController, animated: animated, completion: nil)
    }

    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    func push(_ module: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {

        let controller = module

        // Avoid pushing UINavigationController onto stack
        guard controller is UINavigationController == false else {
            return
        }

        if let completion {
            completions[controller] = completion
        }

        navigationController.pushViewController(controller, animated: animated)
    }

    func pop(animated: Bool = true) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func setRootViewController(_ module: UIViewController, hideBar: Bool = false) {
        // Call all completions so all coordinators can be deallocated
        completions.forEach { $0.value() }
        navigationController.setViewControllers([module], animated: false)
        navigationController.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    func popToViewController(viewController: UIViewController) {
        navigationController.popToViewController(viewController, animated: true)
    }

    func dismissToRootModule(animated: Bool) {
        dismissModule(animated: animated) {
            self.popToRootModule(animated: animated)
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }

    // MARK: Presentable

    func toPresent() -> UIViewController {
        return navigationController
    }

    // MARK: UINavigationControllerDelegate

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController) else {
                return
        }

        runCompletion(for: poppedViewController)
    }
}
