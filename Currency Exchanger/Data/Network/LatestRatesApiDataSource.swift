//
//  LatestRatesApiDataSource.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation
import Combine

protocol LatestRatesNetworkDataSource {
    func fetchLatestRates(baseCurrency: String, symbols: String?) -> AnyPublisher<ExchangeModel, Error>
}

class LatestRatesApiDataSource: LatestRatesNetworkDataSource {
    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }

    func fetchLatestRates(baseCurrency: String, symbols: String? = nil) -> AnyPublisher<ExchangeModel, Error> {
        let request = createLatestRatesRequest(baseCurrency: baseCurrency, symbols: symbols)
        return fetch(request: request)
            .tryMap { data -> ExchangeModel in
                guard let responseData = data else {
                    throw NetworkError.noData
                }
                let decoder = JSONDecoder()
                return try decoder.decode(ExchangeModel.self, from: responseData)
            }
            .mapError { error -> Error in
                // Handle decoding or network errors
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return error
                }
            }
            .eraseToAnyPublisher()
    }

    private func createLatestRatesRequest(baseCurrency: String, symbols: String?) -> LatestRatesRequest {
        return LatestRatesRequest(accessKey: FixerIoApiConstants.apiAccessKey, baseCurrency: baseCurrency, symbols: symbols)
    }

    private func fetch(request: LatestRatesRequest) -> AnyPublisher<Data?, Error> {
        return Future<Data?, Error> { promise in
            self.networkService.execute(request: request) { result in
                switch result {
                case .success(let data):
                    promise(.success(data))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
