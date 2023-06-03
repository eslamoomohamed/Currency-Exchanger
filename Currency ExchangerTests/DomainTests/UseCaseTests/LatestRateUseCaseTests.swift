//
//  LatestRateUseCaseTests.swift
//  Currency ExchangerTests
//
//  Created by eslam mohamed on 03/06/2023.
//

import XCTest
import Combine
@testable import Currency_Exchanger

class LatestRateUseCaseTests: XCTestCase {

    var useCase: LatestRateUseCase!
    var repositoryStub: LatestRatesAPIRepositoryStub!

    override func setUp() {
        super.setUp()
        repositoryStub = LatestRatesAPIRepositoryStub()
        useCase = LatestRateUseCase(latestRatesRepository: repositoryStub)
    }

    override func tearDown() {
        useCase = nil
        repositoryStub = nil
        super.tearDown()
    }

    func testFetchLatestRates_Success() {
        let expectedExchangeModel = ExchangeModel(success: true,
                                                  timestamp: 1622728800,
                                                  base: "EUR",
                                                  date: "2021-06-03",
                                                  rates: ["EGP": 33.34])
        repositoryStub.resultToBeReturned = .success(expectedExchangeModel)

        let expectation = XCTestExpectation(description: "Fetch latest rates")
        var receivedExchangeModel: ExchangeModel?

        _ = useCase.fetchLatestRates(baseCurrency: "EUR")
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { exchangeModel in
                receivedExchangeModel = exchangeModel
            })

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(receivedExchangeModel, expectedExchangeModel)
    }

    func testFetchLatestRates_Failure() {
        let expectedError = NSError(domain: "test", code: 0, userInfo: nil)
        repositoryStub.resultToBeReturned = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Fetch latest rates")
        var receivedError: Error?

        _ = useCase.fetchLatestRates(baseCurrency: "USD")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { _ in })

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(receivedError)
        XCTAssertEqual((receivedError as NSError?)?.domain, expectedError.domain)
        XCTAssertEqual((receivedError as NSError?)?.code, expectedError.code)
    }
}
