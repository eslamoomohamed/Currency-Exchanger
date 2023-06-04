//
//  LatestRateUseCaseInterfaceMock.swift
//  Currency ExchangerTests
//
//  Created by eslam mohamed on 04/06/2023.
//

import XCTest
import Combine
@testable import Currency_Exchanger

final class LatestRateUseCaseInterfaceMock: LatestRateUseCaseInterface {

    var resultToBeReturned: Result<ExchangeModel, Error>!

    func fetchLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error> {
        return Result.Publisher(resultToBeReturned)
            .eraseToAnyPublisher()
    }
}
