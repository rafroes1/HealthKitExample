//
//  Step.swift
//  HealthKikExample
//
//  Created by Rafael Carvalho on 31/03/25.
//

import Foundation

struct Step: Identifiable, Comparable {
    
    let id: UUID = UUID()
    let count: Int
    let date: Date
    
    static func < (lhs: Step, rhs: Step) -> Bool {
        return lhs.date < rhs.date
    }
}
