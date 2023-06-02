//
//  AppCoordinator.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

final class AppCoordinator: BaseCoordinator {

    private let dependencyProvider: DependencyProvider
    override init(router: RouterType) {
        self.dependencyProvider = DependencyProvider()
        super.init(router: router)
    }

    override func start() {
        showCurrencyVC()
    }
}

extension AppCoordinator {

    func showCurrencyVC() {
        let currencyVC = CurrencyConversionVC.loadFromStoryboard()
        let currencyConversionUseCase = dependencyProvider.useCasesAssembler.assembleCurrencyConversionUseCase()
        let latestRatesUseCase = dependencyProvider.useCasesAssembler.assembleLatestRateUseCase()
        currencyVC.currencyViewModel = CurrencyConversionViewModel(currencyConversionUseCase: currencyConversionUseCase,
                                                                   latestRatesUseCase: latestRatesUseCase,
                                                                   transactionDB: dependencyProvider.transactionDb)
        currencyVC.shouldShowDetailsScreen = { [weak self] in
            self?.showCurrenciesDetailsVC()
        }
        currencyVC.shouldShowRecentScreen = { [weak self] in
            self?.showRecentConversionsVC()

        }
        currencyVC.shouldShowOtherCurrenciesScreen = { [weak self] transactionsModel in
            self?.showOtherCurrenciesConversion(transactionModel: transactionsModel)

        }
        router.setRootViewController(currencyVC, hideBar: false)
    }

    func showCurrenciesDetailsVC() {
        let currencyDetailsVC = CurrenciesDetailsVC.loadFromStoryboard()
        let transactionObjs = dependencyProvider.transactionDb.realmObjects(type: TransactionObject.self)
        let currentDate = Date()
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!
        var transactions: [TransactionModel] = []
        transactionObjs?
            .forEach {
                let transactionModel = TransactionModel(transactionObject: $0)
                if transactionModel.transactionDate < threeDaysAgo {
                    dependencyProvider.transactionDb.deleteObject(object: $0)
                } else {
                    transactions.append( TransactionModel(transactionObject: $0))
                }

            }
        currencyDetailsVC.currenciesDetailsViewModel = CurrenciesDetailsViewModel(transactions: transactions)
        router.push(currencyDetailsVC, animated: true, completion: nil)
    }

    func showRecentConversionsVC() {
        let recentConversionsVC = RecentConversionsVC.loadFromStoryboard()
        let transactionObjs = dependencyProvider.transactionDb.realmObjects(type: TransactionObject.self)
        let currentDate = Date().toString(.long)
        var transactions: [TransactionModel] = []
        transactionObjs?
            .forEach {
                let transactionModel = TransactionModel(transactionObject: $0)
                if transactionModel.transactionDate.toString(.long) == currentDate {
                    transactions.append( TransactionModel(transactionObject: $0))
                }

            }
        recentConversionsVC.recentConversionsViewModel = RecentConversionsViewModel(transactions: transactions)
        router.push(recentConversionsVC, animated: true, completion: nil)
    }

    func showOtherCurrenciesConversion(transactionModel: [TransactionModel]) {
        let otherCurrenciesConverionsVC = OtherCurrenciesConverionsVC.loadFromStoryboard()
        let viewModel = OtherCurrenciesConverionsViewModel(transactionsModel: transactionModel)
        otherCurrenciesConverionsVC.otherCurrenciesConverionsViewModel = viewModel
        router.push(otherCurrenciesConverionsVC, animated: true, completion: nil)

    }

}
