//
//  LatestRatesRepository.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol LatestRatesRepository {
    func fetchLatestRates(baseCurrency: String, completion: @escaping (Result<ExchangeModel, Error>) -> Void)
}
