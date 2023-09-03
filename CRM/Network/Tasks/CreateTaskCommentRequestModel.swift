//
//  CreateTaskCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Create Task Comment Request Model
public struct CreateTaskCommentRequestModel: Encodable {
    public let taskId: Int
    public let comment: String
    
    public init(taskId: Int,
                comment: String
    ) {
        self.taskId = taskId
        self.comment = comment
    }
}
