//
//  CurrencyConversionViewModel.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation
import Combine

protocol ICurrencyConversionViewModel {
    func getLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error>
    func getLatestRatesList(baseCurrency: String)
}

class CurrencyConversionViewModel: ICurrencyConversionViewModel {

    private let latestRatesUseCase: LatestRateUseCaseInterface
    private var exchangeModel: ExchangeModel?
    private let transactionDB: RealmDbType
    private var listCancellable: AnyCancellable?
    private var exchangeValueSubscriber: AnyCancellable?
    lazy var listOfCurrenciesSubject = CurrentValueSubject<[String],
                                                           Never>(retrieveListOfCurrenciesFromUserDefaults() ?? [])
    @Published var exchangeValue = 1.0
    var randomTransactions: [TransactionModel] = [TransactionModel]()

    init(latestRatesUseCase: LatestRateUseCaseInterface,
         transactionDB: RealmDbType) {
        self.latestRatesUseCase = latestRatesUseCase
        self.transactionDB = transactionDB
        getLatestRatesList(baseCurrency: FixerIoApiConstants.baseCurrency)
    }

}

extension CurrencyConversionViewModel {

    func getLatestRates(baseCurrency: String, symbols: String? = nil) -> AnyPublisher<ExchangeModel, Error> {
        return latestRatesUseCase.fetchLatestRates(baseCurrency: baseCurrency, symbols: symbols)
    }

    func getLatestRatesList(baseCurrency: String) {
        guard retrieveListOfCurrenciesFromUserDefaults() == nil else {return}
        listCancellable = latestRatesUseCase.fetchLatestRates(baseCurrency: baseCurrency, symbols: nil)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { exchangeModel in
                self.listOfCurrenciesSubject.send(Array(exchangeModel.rates.keys))
                self.exchangeModel = exchangeModel
                UserDefaults.standard.set(Array(exchangeModel.rates.keys), forKey: "ListOfCurrencies")
            })
    }
}

// MARK: Save currency list to user defaults
extension CurrencyConversionViewModel {

    private func retrieveListOfCurrenciesFromUserDefaults() -> [String]? {
        return UserDefaults.standard.array(forKey: "ListOfCurrencies") as? [String]
    }

    func createDataBaseItem(amount: Double,
                            base: String,
                            doubleFromCurrency: Double,
                            target: String,
                            doubleToCurrency: Double,
                            exchangeRate: Double,
                            shouldSkipID: Bool = false) -> TransactionModel {
        var id = self.transactionDB.initializeId()
        if shouldSkipID {
            id = 0
        }

        return  TransactionModel(id: id,
                                 transactionId: "transactionId \(id)",
                                 transactionDate: Date(),
                                 fromCurrencyCode: base,
                                 fromCurrency: doubleFromCurrency,
                                 toCurrencyCode: target,
                                 toCurrency: doubleToCurrency,
                                 exchangeRate: exchangeRate,
                                 amount: amount)
    }

    private func saveToDataBase(transactionModel: TransactionModel) {
        let transactionObject = TransactionObject(transactionModel: transactionModel)
        self.transactionDB.save(object: transactionObject)
    }
}

// MARK: Change currency
extension CurrencyConversionViewModel {

    func convertCurrency(amount: Double = 1, base: String, target: String) {
        exchangeValueSubscriber =  getLatestRates(baseCurrency: "EUR")
            .sink(receiveCompletion: { completion in
        }, receiveValue: { exchangeModel in
            self.exchangeModel = exchangeModel
            let doubleToCurrency = self.extractCurrencyValue(currencyKey: target)
            self.exchangeValue = self.convertCurrency(amount: amount,
                                                      baseToTargetRate: self.extractCurrencyValue(currencyKey: base),
                                                      targetToBaseRate: self.extractCurrencyValue(currencyKey: target))
            DispatchQueue.main.async {
                let doubleFromCurrency = self.extractCurrencyValue(currencyKey: base)
                self.saveToDataBase(transactionModel: self.createDataBaseItem(amount: amount,
                                                                              base: base,
                                                                              doubleFromCurrency: doubleFromCurrency,
                                                                              target: target,
                                                                              doubleToCurrency: doubleToCurrency,
                                                                              exchangeRate: self.exchangeValue))
                self.convertToRandomCurrencies(amount: amount, base: base)
            }

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

    func convertToRandomCurrencies(amount: Double, base: String) {
        randomTransactions.removeAll()
        let targetCurrencies = getRandomCurrencies()

        for currency in targetCurrencies {
            let exchangeValue = self.convertCurrency(amount: amount,
                                                     baseToTargetRate: self.extractCurrencyValue(currencyKey: base),
                                                     targetToBaseRate: self.extractCurrencyValue(currencyKey: currency))
            let doubleFromCurrency = self.extractCurrencyValue(currencyKey: base)
            let doubleToCurrency = self.extractCurrencyValue(currencyKey: currency)
            randomTransactions.append(createDataBaseItem(amount: amount,
                                                         base: base,
                                                         doubleFromCurrency: doubleFromCurrency,
                                                         target: currency,
                                                         doubleToCurrency: doubleToCurrency,
                                                         exchangeRate: exchangeValue,
                                                         shouldSkipID: true))

        }
    }

    func getRandomCurrencies() -> [String] {
        guard let rates = self.exchangeModel?.rates else {
            return []
        }

        let allCurrencies = Array(rates.keys)
        let randomCurrencies = Array(allCurrencies.shuffled().prefix(10))
        return randomCurrencies
    }
}
