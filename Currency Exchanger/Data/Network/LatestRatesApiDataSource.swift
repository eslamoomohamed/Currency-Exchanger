//
//  LatestRatesApiDataSource.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

protocol LatestRatesNetworkDataSource {
    func fetchLatestRates(baseCurrency: String, completion: @escaping (Result<ExchangeModel, Error>) -> Void)
}

class LatestRatesApiDataSource: LatestRatesNetworkDataSource {
    
    private let networkService: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }

    func fetchLatestRates(baseCurrency: String, completion: @escaping (Result<ExchangeModel, Error>) -> Void) {
        
        fetch(request: createLatestRatesRequest(baseCurrency: baseCurrency), completion: completion)
    }

    private func createLatestRatesRequest(baseCurrency: String) -> LatestRatesRequest {
        return LatestRatesRequest(accessKey: FixerIoApiConstants.apiAccessKey, baseCurrency: baseCurrency)
    }

    private func fetch(request: LatestRatesRequest, completion: @escaping (Result<ExchangeModel, Error>) -> Void) {
        networkService.execute(request: request) { result in
            switch result {
            case .success(let data):
                // Parse the data into CurrencyConversionModel
                if let responseData = data {
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(ExchangeModel.self, from: responseData)
                        completion(.success(model))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
