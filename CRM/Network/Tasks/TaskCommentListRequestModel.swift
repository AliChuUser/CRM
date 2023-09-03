//
//  TaskCommentListRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Task Comment List Request Model
public struct TaskCommentListRequestModel: Encodable {
    public let taskId: Int
    public let paging: Paging
    public var filter: [Filter]?
    public var sort: [Sort]?
    
    public init(taskId: Int,
                paging: Paging,
                filter: [Filter]? = nil,
                sort: [Sort]? = nil
    ) {
        self.taskId = taskId
        self.paging = paging
        if let filter = filter { self.filter = filter }
        if let sort = sort { self.sort = sort }
    }
}
