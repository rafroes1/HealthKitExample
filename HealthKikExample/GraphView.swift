//
//  GraphView.swift
//  HealthKikExample
//
//  Created by Rafael Carvalho on 31/03/25.
//

import SwiftUI

struct GraphView: View {
    let steps: [Step]
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            ForEach(steps) { step in
                let yValue = Swift.min(step.count/20, 150)
                
                VStack {
                    Text("\(step.count)")
                        .font(.caption)
                        .foregroundStyle(.white)
                    Rectangle()
                        .fill(step.count >= 3000 ? .green : .red)
                        .frame(width: 20, height: CGFloat(yValue))
                    Text("\(step.date, formatter: Self.dateFormatter)")
                        .font(.caption)
                        .foregroundStyle(.white)
                }

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GraphView(steps: [
        Step(count: 4382, date: Date()),
        Step(count: 291, date: Date()),
        Step(count: 8252, date: Date()),
        Step(count: 3029, date: Date())
    ])
}
