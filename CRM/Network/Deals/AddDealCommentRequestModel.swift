//
//  AddDealCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель запроса добавления заметки к сделке
public struct AddDealCommentRequestModel: Encodable {
    public let prospectId: Int
    public var comment: String
    
    public init(prospectId: Int,
                comment: String
    ) {
        self.prospectId = prospectId
        self.comment = comment
    }
}
