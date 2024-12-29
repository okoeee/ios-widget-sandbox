//
//  SampleWidget.swift
//  SampleWidget
//
//  Created by 横江一真 on 2024/12/29.
//

import WidgetKit
import SwiftUI

struct MyWidgetEntry: TimelineEntry {
    let date: Date
}

struct MyWidgetProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> MyWidgetEntry {
        MyWidgetEntry(
            date: Date()
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(MyWidgetEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MyWidgetEntry>) -> Void) {
        let timeline = Timeline(entries: [MyWidgetEntry(date: Date())], policy: .atEnd)
        completion(timeline)
    }
    
}

struct MyWidgetEntryView: View {
    
    var entry: MyWidgetEntry
    
    var body: some View {
        Text("Hello, Natsu!!")
    }
    
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MyWidgetProvider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is a Sample Widget")
    }
}
