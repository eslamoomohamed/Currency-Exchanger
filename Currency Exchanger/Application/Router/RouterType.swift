//
//  RouterType.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import UIKit

protocol RouterType {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }
    func push(_ module: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
    func toPresent() -> UIViewController
    func setRootViewController(_ module: UIViewController, hideBar: Bool)
}
