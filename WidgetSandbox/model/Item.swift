//
//  item.swift
//  WidgetSandbox
//
//  Created by 横江一真 on 2024/12/31.
//

import Foundation
import AppIntents
import SwiftData

// @Modelをつけることでリアクティブなデータバインディングをサポートするモデルとして機能する
// モデルの変更がSwiftUIのViewに反映される
@Model
final class Item {
    var id: UUID
    var taskName: String
    var priority: String
    var timestamp: Date
    
    init(
        id: UUID,
        taskName: String,
        priority: String,
        timestamp: Date
    ) {
        self.id = id
        self.taskName = taskName
        self.priority = priority
        self.timestamp = timestamp
    }
    
}
