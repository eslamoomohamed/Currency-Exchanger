//
//  Helpers.swift
//  Currency ExchangerTests
//
//  Created by eslam mohamed on 04/06/2023.
//

import XCTest

extension XCTestCase {

    func removePersistentDomain() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
            UserDefaults.standard.synchronize()
        }
    }

    // swiftlint:disable all
    func loadJSONFromBundle(withName name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }

    func decodeJSONData<T: Decodable>(data: Data) -> T {
        return try! JSONDecoder().decode(T.self, from: data)
    }
    // swiftlint:enable all
}
