//
//  CommentsListRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Company Comments List Request Model
public struct CompanyCommentsListRequestModel: Encodable {
    public let customerId: String
    public let paging: Paging
    public var filter: [Filter]?
    public var sort: [Sort]?
    
    public init(customerId: String,
                paging: Paging,
                filter: [Filter]? = nil,
                sort: [Sort]? = nil
    ) {
        self.customerId = customerId
        self.paging = paging
        if let filter = filter { self.filter = filter }
        if let sort = sort { self.sort = sort }
    }
}
