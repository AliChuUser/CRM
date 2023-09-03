//
//  DealCommentsListResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель ответа списка заметок сделки
public struct DealCommentsListResponseModel: ResponseProtocol {
     public let data: [DealCommentsListItemModel]
        // let commonErrors: [JSONAny]
    }


// MARK: - Модель элемента списка заметок сделки
public struct DealCommentsListItemModel: Decodable {
    public let id: Int
    public let comment: String
    public let createdBy: String
    public let createdDate: String
    public let updatedBy: String
    public let updatedDate: String
    public let prospectID: Int
    public let isEditable: Bool
}
