//
//  StoryboardLoadable.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import UIKit

protocol StoryboardLoadable {

    static var storyboardId: String { get }

    static var storyboardControllerId: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
    static var storyboardId: String {
        return String(describing: Self.self)
    }

    static var storyboardControllerId: String {
        return String(describing: Self.self)
    }

    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: Self.storyboardId, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Self.storyboardControllerId) as! Self
    }
}
