//
//  CompanyCommentResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Company Comment Response Model
public struct CompanyCommentResponseModel: ResponseProtocol {
     public let data: [CompanyCommentModel]
//     let commonErrors: [JSONAny]
}

// MARK: - Company Comment Model
public struct CompanyCommentModel: Decodable {
    public let id: Int
    public let comment: String
    public let createdDate: String
    public let createdBy: String
    public let updatedDate: String
    public let updatedBy: String
    public let dzoId: Int
    public let customerId: Int
}
