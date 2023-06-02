//
//  TransactionDb.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import Foundation
import RealmSwift

class TransactionDb: RealmDbType {
    var dbName: String { "TransactionDB" }
    var schemaVersion: UInt64 { 1 }
    var objectTypes: [Object.Type] {[TransactionObject.self]}
    var realm: Realm?

    static let shared: TransactionDb = TransactionDb()
    private init() {
        self.initializeDB { success, _ in
            if !success {
                print("TransactionDb failed to initialize")
            }
        }
    }
}

extension TransactionDb {
    func initializeId() -> Int {
        return (self.realmObjects(type: TransactionObject.self)?.map { $0.id }.max() ?? 0) + 1
    }
}
