//
//  ContentView.swift
//  HealthKikExample
//
//  Created by Rafael Carvalho on 31/03/25.
//

import HealthKit
import SwiftUI

struct ContentView: View {
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    
    @AppStorage("stepCount", store: UserDefaults(suiteName: "group.com.HKExample"))
    var stepCount = 0
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0, +)
    }

    init() {
        healthStore = HealthStore()
    }

    func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date()
        let endDate = Date()

        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
            
            stepCount = totalSteps
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Last 7 days total steps: \(totalSteps)")
                    .italic()
                    .opacity(0.7)
                    .padding(.leading, 20)
                
                List(steps.sorted(by: { $0 > $1 })) { step in
                    VStack(alignment: .leading) {
                        Text(step.date, style: .date)
                            .font(.headline)

                        Text("Steps: \(step.count)")
                            .font(.subheadline)
                            .foregroundStyle(step.count >= 3000 ? .green : .red)
                    }
                }
                
                GraphView(steps: steps)
            }
            .navigationTitle("Steps Counter")
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requiresAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

// #Preview {
//    ContentView()
// }
