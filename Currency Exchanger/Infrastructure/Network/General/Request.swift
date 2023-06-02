//
//  Request.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol Request {

    var path: String { get }

    var method: HTTPMethod { get }

    var parameters: RequestParams { get }

    var headers: [HTTPHeaderName: String]? { get }
}

extension Request {
    var method: HTTPMethod {
        return .get
    }

    var headers: [HTTPHeaderName: String]? {
        return nil
    }
}
