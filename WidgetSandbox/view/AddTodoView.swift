//
//  TodoView.swift
//  WidgetSandbox
//
//  Created by 横江一真 on 2024/12/31.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
    
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var taskName: String = ""
    @State private var priority: String = ""
    @State private var showAlert = false
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    let priorities = ["Low", "Middle", "High"]
    
    var body: some View {
       NavigationStack {
           VStack {
               TextField("todo here", text: $taskName)
                   .padding()
                   .background(Color(.systemGray6))
                   .cornerRadius(10)
                   .padding(.horizontal)
                   .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                   .contentShape(Rectangle())
                   .onTapGesture {
                       isTextFieldFocused = true
                   }
                   .focused($isTextFieldFocused)
               
               Picker("優先度", selection: $priority) {
                   ForEach (priorities, id: \.self) {
                       Text($0)
                   }
               }
               .pickerStyle(SegmentedPickerStyle())
               .frame(maxWidth: .infinity)
               .frame(height: 50)
               .padding(.horizontal)
               .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
               
               Button(action: addItem) {
                   HStack {
                       Image(systemName: "checkmark.circle.fill")
                       Text("Save")
                   }
                   .fontWeight(.medium)
                   .padding()
                   .frame(maxWidth: .infinity) // 横幅いっぱいにする
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(8)
                   .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
               }
               .padding(.horizontal)
               
               Spacer()
           }
           .padding()
           .navigationTitle("New Todo")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .topBarTrailing) {
                   Button {
                       dismiss()
                   } label: {
                       Label("Back", systemImage: "xmark.app.fill")
                   }
               }
           }
           .alert(isPresented: $showAlert) {
               Alert(
                   title: Text("エラー"),
                   message: Text("タスク名を入力してください"),
                   dismissButton: .default(Text("OK"))
               )
           }
       }
   }

    private func addItem() {
        if taskName.isEmpty {
            showAlert = true
        } else {
            withAnimation {
                let newItem = Item(
                    id: UUID(),
                    taskName: taskName,
                    priority: priority,
                    timestamp: Date()
                )
                modelContext.insert(newItem)
                dismiss()
            }
        }
    }
    
    
}

#Preview {
    AddTodoView()
        .modelContainer(for: Item.self, inMemory: false)
}
