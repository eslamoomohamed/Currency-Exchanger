//
//  RealmDbType.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import Foundation
import RealmSwift

protocol RealmDbType: AnyObject {
    var dbName: String { get }
    var realm: Realm? { get set }
    var schemaVersion: UInt64 { get }
    var objectTypes: [Object.Type] { get }
    
    func initializeDB(completion: (_ success: Bool, _ error: Error?) -> Void)
    func save<T: Object>(object: T)
    func realmObjects<T: Object>(type: T.Type) -> [T]?
    func initializeId() -> Int
    func deleteObject<T: Object>(object: T)
}

extension RealmDbType {
    public func initializeDB(completion: (_ success: Bool, _ error: Error?) -> Void) {
        do { let dbURL = getDBURL(name: dbName)
            let config = Realm.Configuration(fileURL: dbURL,
                                             schemaVersion: schemaVersion,
                                             objectTypes: objectTypes)
            self.realm = try Realm(configuration: config)
            completion(true, nil)
        } catch let error {
            completion(false, error)
        }
    }

    public func save<T: Object>(object: T) {
        do {
            try self.realm?.write {
                self.realm?.add(object, update: .modified)
            }
        } catch (let error) {
            fatalError("RealmDB: (\(dbName)), save[T]: \(error.localizedDescription)")
        }
    }

    public func realmObjects<T: Object>(type: T.Type) -> [T]? {
        return self.realm?.objects(T.self).compactMap { $0 }
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

extension RealmDbType {
    private func getDBURL(name: String) -> URL {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url: URL =  URL(fileURLWithPath: documentsPath).appendingPathComponent("Realm")
        
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) {
            if !isDir.boolValue {
                createDirectory(url)
            }
        } else {
            createDirectory(url)
        }
        
        let dbURL = url.appendingPathComponent(name)
        return dbURL
    }
    
    private func createDirectory(_ path: URL) {
        do {
            try FileManager.default.createDirectory(at: path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
        } catch {
            fatalError("RealmDB: (\(dbName)), init: unable to create a directory at path \(path)")
        }
    }
}
