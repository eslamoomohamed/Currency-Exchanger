//
//  CurrencyConversionViewModelTests.swift
//  Currency ExchangerTests
//
//  Created by eslam mohamed on 03/06/2023.
//

import XCTest
import Combine
@testable import Currency_Exchanger

class CurrencyConversionViewModelTests: XCTestCase {

    var viewModel: CurrencyConversionViewModel!
    var latestRatesUseCaseMock: LatestRateUseCaseInterfaceMock!
    var realmDbTypeMock: RealmDbTypeMock!

    override func setUp() {
        super.setUp()

        latestRatesUseCaseMock = LatestRateUseCaseInterfaceMock()
        realmDbTypeMock = RealmDbTypeMock()
        viewModel = CurrencyConversionViewModel(latestRatesUseCase: latestRatesUseCaseMock,
                                                transactionDB: realmDbTypeMock)
    }

    override func tearDown() {
        latestRatesUseCaseMock = nil
        realmDbTypeMock = nil
        viewModel = nil

        super.tearDown()
    }

    func testGetLatestRates_Success() {
        let exchangeModel = ExchangeModel(success: true,
                                          timestamp: 1234567890,
                                          base: "EUR",
                                          date: "2023-06-03",
                                          rates: ["USD": 1.2, "EGP": 35.4])

        latestRatesUseCaseMock.resultToBeReturned = .success(exchangeModel)

        let expectation = XCTestExpectation(description: "Get latest rates")
        let cancellable = viewModel.getLatestRates(baseCurrency: "EUR")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Failed to get latest rates: \(error)")
                }
            }, receiveValue: { receivedModel in
                XCTAssertEqual(receivedModel, exchangeModel)
                expectation.fulfill()
            })
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }

    func testGetLatestRates_Failure() {
        let expectedError = NSError(domain: "test", code: 405, userInfo: nil)
        latestRatesUseCaseMock.resultToBeReturned = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Get latest rates")
        let cancellable = viewModel.getLatestRates(baseCurrency: "EUR")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error as NSError, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected a failure, but received a value")
            })
        wait(for: [expectation], timeout: 1.0)
        cancellable.cancel()
    }

    func testConvertCurrency_Success() {
        let exchangeModel = ExchangeModel(success: true,
                                          timestamp: 1234567890,
                                          base: "EUR",
                                          date: "2023-06-03",
                                          rates: ["USD": 1.2, "EGP": 35.4])

        latestRatesUseCaseMock.resultToBeReturned = .success(exchangeModel)
        viewModel.convertCurrency(amount: 2, base: "USD", target: "EGP")

        XCTAssertEqual(viewModel.exchangeValue, 59.0)
    }

    func testConvertCurrency_Failure() {
        let exchangeModel = ExchangeModel(success: true,
                                          timestamp: 1234567890,
                                          base: "EUR",
                                          date: "2023-06-03",
                                          rates: ["USD": 1.2, "EGP": 35.4])

        latestRatesUseCaseMock.resultToBeReturned = .success(exchangeModel)
        viewModel.convertCurrency(amount: 2, base: "USD", target: "EGP")

        XCTAssertNotEqual(viewModel.exchangeValue, 20)
    }

    func testConvertToRandomCurrencies_Success() {
        let exchangeModel = ExchangeModel(success: true,
                                          timestamp: 1234567890,
                                          base: "EUR",
                                          date: "2023-06-03",
                                          rates: ["USD": 1.2, "EGP": 35.4, "AED": 3.939403,
                                                  "AFN": 93.861958,
                                                  "ALL": 108.840675,
                                                  "AMD": 415.16443,
                                                  "ANG": 1.940334,
                                                  "AOA": 639.785181,
                                                  "ARS": 258.607144,
                                                  "AUD": 1.622139,
                                                  "AWG": 1.933286,
                                                  "AZN": 1.827607,
                                                  "BAM": 1.955632,
                                                  "BBD": 2.173814,
                                                  "BDT": 115.500104,
                                                  "BGN": 1.958287,
                                                  "BHD": 0.403665])
        removePersistentDomain()
        latestRatesUseCaseMock.resultToBeReturned = .success(exchangeModel)
        viewModel.getLatestRatesList(baseCurrency: "EUR")
        viewModel.convertToRandomCurrencies(amount: 100, base: "EGP")
        XCTAssertEqual(viewModel.randomTransactions.count, 10)
    }

    func testConvertToRandomCurrencies_Failure() {
        viewModel.convertToRandomCurrencies(amount: 100, base: "EGP")
        XCTAssertTrue(viewModel.randomTransactions.isEmpty)
    }

}
