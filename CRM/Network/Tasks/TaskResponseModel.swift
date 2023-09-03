//
//  TaskResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - TaskResponseModel
public struct TaskResponseModel: ResponseProtocol {
    public let data: TaskModel
}

// MARK: - DataClass
public struct TaskModel: Decodable {
    public let id: Int
    public let taskName: String
    public let text: String
    public let taskType: String
    public let taskTypeCode: String
    public let taskStatus: String
    public let taskStatusCode: String
    public let taskPriority: String
    public let taskPriorityCode: String
    public let taskAsignee: String
    public let customerShortName: String
    public let customerID: Int
    public let prospectID: Int
    public let dateTermination: String
    public let taskResult: String
    public let taskResultCode: String
    public let taskResultText: String
    public let createdDate: String
    public let createdBy: String
    public let updatedDate: String
    public let updatedBy: String
}
