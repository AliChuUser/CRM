//
//  CompanyCommentsListResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Company Comments List Response Model
public struct CompanyCommentsListResponseModel: ResponseProtocol {
     public let data: [CompanyCommentListItemModel]
//     let commonErrors: [JSONAny]
}

// MARK: - Company Comment Model
public struct CompanyCommentListItemModel: Decodable {
    public let id: Int
    public let comment: String
    public let createdDate: String
    public let createdBy: String
    public let updatedDate: String
    public let updatedBy: String
    public let dzoId: Int
    public let customerId: Int
    public let versionUpdate: String
}
