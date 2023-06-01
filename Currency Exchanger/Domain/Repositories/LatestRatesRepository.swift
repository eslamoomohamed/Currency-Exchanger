//
//  LatestRatesRepository.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation
import Combine

protocol LatestRatesRepository {
    func fetchLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error>
}
