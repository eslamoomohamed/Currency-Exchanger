//
//  NetworkServiceInterface.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol NetworkServiceInterface {
    func execute(request: Request, completion: @escaping (Result<Data?, Error>) -> Void)
}
