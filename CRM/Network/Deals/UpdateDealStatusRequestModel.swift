//
//  UpdateDealStatusRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - UpdateDealStatusRequestModel
public struct UpdateDealStatusRequestModel: Encodable {
    public let id: String
    public let statusCode: String
    public let status: String
    public let refuseReasonCode: String
    public let refuseReason: String
    public let refuseDescription: String
    public let description: String
    public let kmDzoFullName: String
    public let kmDzoID: Int
    public let potentialStatusUpdateDt: String
    public let lastUpdated: String
    public let updatedBy: Int
    public let versionUpd: Int
    
    public init(id: String,
                statusCode: String,
                status: String,
                refuseReasonCode: String,
                refuseReason: String,
                refuseDescription: String,
                description: String,
                kmDzoFullName: String,
                kmDzoID: Int,
                potentialStatusUpdateDt: String,
                lastUpdated: String,
                updatedBy: Int,
                versionUpd: Int
    ) {
        self.id = id
        self.statusCode = statusCode
        self.status = status
        self.refuseReasonCode = refuseReasonCode
        self.refuseReason = refuseReason
        self.refuseDescription = refuseDescription
        self.description = description
        self.kmDzoFullName = kmDzoFullName
        self.kmDzoID = kmDzoID
        self.potentialStatusUpdateDt = potentialStatusUpdateDt
        self.lastUpdated = lastUpdated
        self.updatedBy = updatedBy
        self.versionUpd = versionUpd
    }
}
