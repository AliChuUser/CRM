//
//  DealStatusChangeHistoryRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Модель запроса истории изменения статусов сделки
public struct DealStatusChangeHistoryRequestModel: Encodable {
    public let prospectId: Int
    public let paging: Paging
    public var filter: [Filter]?
    public var sort: [Sort]?
    
    public init(prospectId: Int,
                paging: Paging,
                filter: [Filter]? = nil,
                sort: [Sort]? = nil
    ) {
        self.prospectId = prospectId
        self.paging = paging
        if let filter = filter { self.filter = filter }
        if let sort = sort { self.sort = sort }
    }
}
