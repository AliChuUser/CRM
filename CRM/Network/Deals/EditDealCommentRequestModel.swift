//
//  EditDealCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель запроса редактирования заметки к сделке
public struct EditDealCommentRequestModel: Encodable {
    public let prospectId: Int
    public let id: Int
    public var comment: String
    
    public init(prospectId: Int,
                id: Int,
                comment: String
    ) {
        self.prospectId = prospectId
        self.id = id
        self.comment = comment
    }
}
