//
//  LatestRatesAPIRepositoryStub.swift
//  Currency ExchangerTests
//
//  Created by eslam mohamed on 03/06/2023.
//

import XCTest
import Combine
@testable import Currency_Exchanger

final class LatestRatesAPIRepositoryStub: LatestRatesRepository {

    var resultToBeReturned: Result<ExchangeModel, Error>!

    func fetchLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error> {
        return Result.Publisher(resultToBeReturned)
            .eraseToAnyPublisher()
    }

}
