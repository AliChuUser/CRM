//
//  ChangeTaskStatusResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - ChangeTaskStatusResponseModel
public struct ChangeTaskStatusResponseModel: ResponseProtocol {
    public let modelStatusTask: [ModelStatusTask]
}

// MARK: - ModelStatusTask
public struct ModelStatusTask: Decodable {
    public let buttonName, buttonCode: String
    public let buttonOrder: Int
    public let current, taskStatusCode: String
    public let childButton: [ModelStatusTask]?
}
