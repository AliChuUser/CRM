//
//  DeleteDealCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель запроса редактирования заметки к сделке
public struct DeleteDealCommentRequestModel: Encodable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
