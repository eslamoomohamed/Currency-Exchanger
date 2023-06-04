//
//  RealmDbTypeMock.swift
//  Currency ExchangerTests
//
//  Created by eslam mohamed on 04/06/2023.
//

import Foundation
import RealmSwift
@testable import Currency_Exchanger

class RealmDbTypeMock: RealmDbType {

    var dbName: String {
        return "MockDB"
    }

    var realm: Realm?

    var schemaVersion: UInt64 {
        return 1
    }

    var objectTypes: [Object.Type] {
        return [TransactionObject.self]
    }
    var realmObject: [Object] = []
    var savedObject: Object?
    var saveTransactionCalledWithObject: Object?

    var initializeDBCompletion: ((Bool, Error?) -> Void)?

    func initializeDB(completion: @escaping (Bool, Error?) -> Void) {
        initializeDBCompletion = completion
    }

    func save<T: Object>(object: T) {
        saveTransactionCalledWithObject = object
    }

    func realmObjects<T: Object>(type: T.Type) -> [T]? {
        return realmObject as? [T]
    }

    func initializeId() -> Int {
        return 0
    }

    func deleteObject<T: Object>(object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            print("Failed to delete object: \(error)")
        }

    }
}
