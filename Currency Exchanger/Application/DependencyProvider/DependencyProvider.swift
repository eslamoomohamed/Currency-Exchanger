//
//  DependencyProvider.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 31/05/2023.
//

import Foundation

class DependencyProvider {

    let networkService: NetworkService
    let repositoryAssembler: RepositoryAssembler
    let useCasesAssembler: UseCasesAssembler
    let transactionDb: RealmDbType

    init() {
        networkService = NetworkService(session: URLSession.shared)
        repositoryAssembler = RepositoryAssembler(networkService: networkService)
        useCasesAssembler = UseCasesAssembler(repositoryAssembler: repositoryAssembler)
        transactionDb = TransactionDb.shared
    }

}
