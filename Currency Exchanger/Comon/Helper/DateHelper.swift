//
//  DateHelper.swift
//  Currency Exchanger
//
//  Created by eslam mohamed on 01/06/2023.
//

import Foundation

import Foundation

enum DateFormat {
    case long
}
extension Date {
    func toString(_ format: DateFormat = .long) -> String {
        let dateFormatter = DateFormatter()
        switch format {
        case .long:
            dateFormatter.dateFormat = "dd-MM-yyyy"
        }
        return dateFormatter.string(from: self)
    }
}
