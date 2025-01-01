//
//  ContentView.swift
//  WidgetSandbox
//
//  Created by 横江一真 on 2024/12/29.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showAddView = false
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    Spacer()
                    Text("No data to display")
                        .foregroundColor(.gray)
                        .font(.title)
                    Spacer()
                } else {
                    List {
                        ForEach(items.sorted(by: { $0.timestamp < $1.timestamp })) { item in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(
                                        item.priority == "High" ? .red :
                                            item.priority == "Middle" ? .yellow :
                                            item.priority == "Low" ? .green :
                                            .gray
                                    )
                                Text(item.taskName)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteItem(item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add Task", systemImage: "plus.app")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddTodoView()
            }
        }
    }
    
    // アイテム削除処理
    private func deleteItem(_ item: Item) {
        modelContext.delete(item)  // contextを使ってItemを削除
        try? modelContext.save()   // 保存
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
