//
//  EditCompanyCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Edit Company Comment Request Model
public struct EditCompanyCommentRequestModel: Encodable {
    public let customerId: Int
    public let id: Int
    public let comment: String
    public let versionUpdate: Int
    
    public init(customerId: Int,
                id: Int,
                comment: String,
                versionUpdate: Int
    ) {
        self.customerId = customerId
        self.id = id
        self.comment = comment
        self.versionUpdate = versionUpdate
    }
}
