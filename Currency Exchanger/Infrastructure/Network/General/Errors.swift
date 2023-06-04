//
//  Errors.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 04/06/2023.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case badInput
    case noData
    case wrongUrl
    case unAuthorized
    case invalidResponse
    case statusCodeError(Int)
}
