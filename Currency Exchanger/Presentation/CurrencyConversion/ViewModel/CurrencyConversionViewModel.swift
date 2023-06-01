//
//  CurrencyConversionViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation
import Combine

protocol ICurrencyConversionViewModel {
    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void)
    func getLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error>
    func getLatestRatesList(baseCurrency: String)
}

class CurrencyConversionViewModel: ICurrencyConversionViewModel {

    private let currencyConversionUseCase: CurrencyConversionUseCaseInterface
    private let latestRatesUseCase: LatestRateUseCaseInterface
    private var exchangeModel: ExchangeModel?
    private var listCancellable: AnyCancellable?
    private var exchangeValueSubscriber: AnyCancellable?
    lazy var listOfCurrenciesSubject = CurrentValueSubject<[String], Never>(retrieveListOfCurrenciesFromUserDefaults() ?? [])
    @Published var exchangeValue = 1.0


    
    init(currencyConversionUseCase: CurrencyConversionUseCaseInterface, latestRatesUseCase: LatestRateUseCaseInterface) {
        self.currencyConversionUseCase = currencyConversionUseCase
        self.latestRatesUseCase = latestRatesUseCase
        getLatestRatesList(baseCurrency: FixerIoApiConstants.baseCurrency)
    }

}

extension CurrencyConversionViewModel {

    func getLatestRates(baseCurrency: String, symbols: String? = nil) -> AnyPublisher<ExchangeModel, Error> {
        return latestRatesUseCase.fetchLatestRates(baseCurrency: baseCurrency, symbols: symbols)
    }

    func convertCurrency(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        currencyConversionUseCase.convertCurrency(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency, completion: completion)
    }
    
    func getLatestRatesList(baseCurrency: String) {
        guard retrieveListOfCurrenciesFromUserDefaults() == nil else {return}
        listCancellable = latestRatesUseCase.fetchLatestRates(baseCurrency: baseCurrency, symbols: nil)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { exchangeModel in
                UserDefaults.standard.set(Array(exchangeModel.rates.keys), forKey: "ListOfCurrencies")
            })
    }
}

// MARK: Save currency list to user defaults
extension CurrencyConversionViewModel {

    private func retrieveListOfCurrenciesFromUserDefaults() -> [String]? {
        return UserDefaults.standard.array(forKey: "ListOfCurrencies") as? [String]
    }

}

// MARK: Change currency
extension CurrencyConversionViewModel {

    func convertCurrency(amount: Double = 1, base: String, target: String) {
        exchangeValueSubscriber =  getLatestRates(baseCurrency: "EUR")
            .sink(receiveCompletion: { completion in
        }, receiveValue: { exchangeModel in
            self.exchangeModel = exchangeModel
            self.exchangeValue = self.convertCurrency(amount: amount, baseToTargetRate: self.extractCurrencyValue(currencyKey: base), targetToBaseRate: self.extractCurrencyValue(currencyKey: target))
        })
    }

    func extractCurrencyValue(currencyKey: String) -> Double {
        return exchangeModel?.rates[currencyKey] ?? 0
    }

    private func convertCurrency(amount: Double, baseToTargetRate: Double, targetToBaseRate: Double) -> Double {
        let amountInEuros = amount / baseToTargetRate
        let targetAmount = amountInEuros * targetToBaseRate
        return targetAmount
    }
}
