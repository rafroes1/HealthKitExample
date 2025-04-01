//
//  HealthKitWidget.swift
//  HealthKitWidget
//
//  Created by Rafael Carvalho on 01/04/25.
//

import WidgetKit
import SwiftUI

struct StepEntry: TimelineEntry {
    let date: Date = Date()
    var steps: Int
}

struct Provider: TimelineProvider {
    @AppStorage("stepCount", store: UserDefaults(suiteName: "group.com.HKExample"))
    var stepCount = 0
    
    typealias Entry = StepEntry
    
    func placeholder(in context: Context) -> StepEntry {
        StepEntry(steps: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (StepEntry) -> Void) {
        let entry = StepEntry(steps: stepCount)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<StepEntry>) -> Void) {
        let entry = StepEntry(steps: stepCount)
        completion(Timeline(entries: [entry], policy: .never))
    }
}

struct StepView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("\(entry.steps)")
                .font(.system(size: 72, weight: .bold, design: .default))
                .foregroundStyle(.white)
            Text("total steps this week")
                .font(.subheadline)
                .foregroundStyle(.white)
                .italic()
                
        }
        .containerBackground(entry.steps >= 21000 ? Color.green.gradient : Color.red.gradient, for: .widget)
    }
}

@main
struct StepWidget: Widget {
    private let kind = "StepWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StepView(entry: entry)
        }
    }
}
