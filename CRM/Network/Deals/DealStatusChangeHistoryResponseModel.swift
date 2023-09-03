//
//  DealStatusChangeHistoryResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель ответа истории изменения статуса сделки
public struct DealStatusChangeHistoryResponseModel: ResponseProtocol {
     public let data: [DealGeneralInfoModel]
//     let commonErrors: [JSONAny]
}

// MARK: - Модель элемента списка истории изменения статуса сделки
public struct DealStatusChangeHistoryItemModel: Decodable {
    public let id: Int
    public let statusCode: String
    public let status: String
    public let updatedBy: Int
    public let lastUpd: String
}
