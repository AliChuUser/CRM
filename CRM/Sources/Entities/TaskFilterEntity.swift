//
//  TaskFilterEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class TaskFilterEntity {

    var title: String
    var filterAction: (([TaskEntity]) -> [TaskEntity])

    init(title: String, filterAction: @escaping (([TaskEntity]) -> [TaskEntity])) {
        self.title = title
        self.filterAction = filterAction
    }
}
