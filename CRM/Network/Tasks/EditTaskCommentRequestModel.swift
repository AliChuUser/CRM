//
//  EditTaskCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Edit Task Comment Request Model
public struct EditTaskCommentRequestModel: Encodable {
    public let taskId: Int
    public let id: Int
    public let comment: String
    public let versionUpdate: Int
    
    public init(taskId: Int,
                id: Int,
                comment: String,
                versionUpdate: Int
    ) {
        self.taskId = taskId
        self.id = id
        self.comment = comment
        self.versionUpdate = versionUpdate
    }
}
