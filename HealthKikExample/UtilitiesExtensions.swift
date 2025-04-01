//
//  UtilitiesExtensions.swift
//  HealthKikExample
//
//  Created by Rafael Carvalho on 31/03/25.
//

import Foundation

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

