//
//  RequestParams.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

enum RequestParams {
    case body(_: [String: Any]?)
    case url(_: [String: Any]?)
}
