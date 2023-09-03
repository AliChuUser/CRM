//
//  AddCompanyCommentRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Add Company Comment Request Model
public struct AddCompanyCommentRequestModel: Encodable {
    public let customerId: Int
    public let comment: String
    
    public init(customerId: Int, comment: String) {
        self.customerId = customerId
        self.comment = comment
    }
}
