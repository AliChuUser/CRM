//
//  DealCommentResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель ответа с заметкой к сделке
public struct DealCommentResponseModel: ResponseProtocol {
    public let id: Int
    public let comment: String
    public let createdBy: Person
    public let createdDate: String
    public let updatedBy: Person
    public let updatedDate: String
    public let dzoID: Int
    public let prospectID: Int
    public let isEditable: Bool
}

public struct Person: Decodable {
    public let firstName: String
    public let secondName: String
    public let middleName: String
}
