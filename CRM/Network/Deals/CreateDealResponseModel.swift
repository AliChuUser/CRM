//
//  CreateDealResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Created Deal Response Model
public struct CreatedDealResponseModel: ResponseProtocol {
     public let data: CreatedDealModel
//     let commonErrors: [JSONAny]
}

// MARK: - Created Deal Model
public struct CreatedDealModel: Decodable {
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
    public let descriprtion: String
    public let segment: String
    public let customerType: String
    public let customerTypeCode: String
    public let holdingID: String
    public let holdingName: String
    public let territorialBank: String
    public let timeZone: String
    public let loadUpdated: String
    public let potentialID: String
    public let refuseReason: String
    public let refuseReasonCode: String
    public let refuseDescription: String
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
