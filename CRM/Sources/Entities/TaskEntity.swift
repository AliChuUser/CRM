//
//  TaskEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

enum TaskStatus: String {
    case free = "запланированные"
    case inWork = "в работе"
    case completed = "выполненные"
    case declined = "отмененные"
}

enum TaskType: String {
    case call = "Связаться"
    case task = "Задача"
    case meeting = "Встреча"
    
    static var all: [TaskType] {
        return [.call, .task, .meeting]
    }
}

enum TaskPriority: String {
    case low
    case middle
    case high
    case notAvailable
}

class TaskEntity {
    var id: String
    var title: String
    var dealId: String?
    var deadline: Date
    var assignor: String
    var assignee: String
    var status: TaskStatus?
    var type: TaskType?
    var priority: TaskPriority?
    var comments: String?
    
    init(id: String, title: String, deadline: Date, assignor: String, assignee: String, status: TaskStatus?, type: TaskType?, priority: TaskPriority?, comments: String? = nil) {
        self.id = id
        self.title = title
        self.deadline = deadline
        self.assignor = assignor
        self.assignee = assignee
        self.status = status
        self.type = type
        self.priority = priority
        self.comments = comments
    }
}
