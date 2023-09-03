//
//  TaskCommentListResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - TaskCommentListResponseModel
public struct TaskCommentListResponseModel: ResponseProtocol {
    public let data: [TaskCommentListItemModel]
}

// MARK: - TaskCommentListItemModel
public struct TaskCommentListItemModel: Decodable {
    public let id: Int
    public let comment: String
    public let createdBy: String
    public let createdDate: String
    public let updatedBy: String
    public let updatedDate: String
    public let dzoID: Int
    public let taskID: Int
    public let versionUpdate: Int
}
