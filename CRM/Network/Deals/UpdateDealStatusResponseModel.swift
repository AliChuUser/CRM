//
//  UpdateDealStatusResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Update Deal Status Response Model
public struct UpdateDealStatusResponseModel: ResponseProtocol {
     public let data: UpdatedDealModel
//     let commonErrors: [JSONAny]
}

// MARK: - Updated Deal Model
public struct UpdatedDealModel: Decodable {
    public let id: Int
    public let statusCode: String
    public let status: String
    public let dzoName: String
    public let dzoId: String
    public let product: String
    public let productId: Int
    public let priority: String
    public let priorityCode: String
    public let created: String
    public let lastUpd: String
    public let shortName: String
    public let customerId: Int
    public let inn: String
    public let kpp: String
    public let kmDzoFullName: String
    public let kmDzoId: Int
    public let segment: String
    public let customerType: String
    public let customerTypeCode: String
    public let holdingId: String
    public let holdingName: String
    public let tb: String
    public let timeZone: String
    public let loadUpdated: String
    public let potentialID: String
    public let refuseReason: String
    public let refuseReasonCode: String
    public let refuseComment: String
    public let potentialStatusUpdateDt: String
    public let source: String
    public let sourceCode: String
    public let priorityNum: Int
    public let versionID: String
    public let createdBy: Int
    public let updatedBy: Int
    public let versionUpd: Int
    public let file: String
}
