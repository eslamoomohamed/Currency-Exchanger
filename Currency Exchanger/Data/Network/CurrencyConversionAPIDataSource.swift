//
//  CurrencyConversionAPIDataSource.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol CurrencyConversionNetworkDataSource {
    func fetchCurrencyConversion(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void)
}

class CurrencyConversionAPIDataSource: CurrencyConversionNetworkDataSource {

    private let networkService: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }

    func fetchCurrencyConversion(amount: Double, fromCurrency: Currency, toCurrency: Currency, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        handleResponse(currencyConversionRequest: createCurrencyConversionRequest(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency),
                       completion: completion)
    }

    private func createCurrencyConversionRequest(amount: Double, fromCurrency: Currency, toCurrency: Currency) -> CurrencyConversionRequest {
        return CurrencyConversionRequest(accessKey: FixerIoApiConstants.apiAccessKey, fromCurrency: fromCurrency.code, toCurrency: toCurrency.code, amount: amount, date: nil)
    }
    
    private func handleResponse(currencyConversionRequest: CurrencyConversionRequest, completion: @escaping (Result<CurrencyConversionModel, Error>) -> Void) {
        networkService.execute(request: currencyConversionRequest) { result in
            switch result {
            case .success(let data):
                // Parse the data into CurrencyConversionModel
                if let responseData = data {
                    do {
                        let decoder = JSONDecoder()
                        let currencyConversionModel = try decoder.decode(CurrencyConversionModel.self, from: responseData)
                        completion(.success(currencyConversionModel))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    // Handle the case when data is nil
                    completion(.failure(NetworkError.noData))
                }
                
            case .failure(let error):
                // Handle the network request error
                completion(.failure(error))
            }
        }
    }
}
