//
//  CompanyChangeHistoryResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Company Change History Response Model
public struct CompanyChangeHistoryResponseModel: ResponseProtocol {
     public let organizations: [CompanyChangeHistoryItemModel]
//     let commonErrors: [JSONAny]
}

// MARK: - Company Change History Item Model
public struct CompanyChangeHistoryItemModel: Decodable {
    public let inn: String
    public let kpp: String
    public let name: String
    public let shortName: String
    public let segment: String
    public let orgType: String
    public let orgTypeId: String
    public let holdingName: String
    public let holdingId: String
    public let kmFullName: String
    public let kmPhone: String
    public let kmEmail: String
    public let tkmFullName: String
    public let tkmPhone: String
    public let tkmEmail: String
    public let TB: String
    public let timeZone: String
    public let id: String
    public let crmId: String
    public let createdDate: String
    public let createdBy: String
    public let updatedDate: String
    public let updatedBy: String
}
