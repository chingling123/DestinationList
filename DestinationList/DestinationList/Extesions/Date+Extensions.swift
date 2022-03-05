//
//  Date+Extensions.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
}
