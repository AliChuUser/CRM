//
//  CreateDealRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

/ MARK: - Created Deal Request Model
public struct CreateDealRequestModel: Encodable {
    public let statusCode: String
    public let priorityCode: String
    public let productId: String
    public let customerId: String
    public let inn: String
    public let kpp: String
    public let customerTypeCode: String
    public let holdingName: String
    public let refuseReasonCode: String
    public let refuseDescription: String
    public let description: String
    public let kmDzoId: String
    
    public init(statusCode: String,
                priorityCode: String,
                productId: String,
                customerId: String,
                inn: String,
                kpp: String,
                customerTypeCode: String,
                holdingName: String,
                refuseReasonCode: String,
                refuseDescription: String,
                description: String,
                kmDzoId: String
    ) {
        self.statusCode = statusCode
        self.priorityCode = priorityCode
        self.productId = productId
        self.customerId = customerId
        self.inn = inn
        self.kpp = kpp
        self.customerTypeCode = customerTypeCode
        self.holdingName = holdingName
        self.refuseReasonCode = refuseReasonCode
        self.refuseDescription = refuseDescription
        self.description = description
        self.kmDzoId = kmDzoId
    }
}
