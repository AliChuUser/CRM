//
//  DealCardResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Deal Card Response Model
public struct DealCardResponseModel: ResponseProtocol {
     public let data: DealCardModel
//     let commonErrors: [JSONAny]
}

// MARK: - Deal Card Model
public struct DealCardModel: Decodable {
    public let id: Int
    public let statusCode: String
    public let status: String
    public let dzoName: String
    public let dzoId: String
    public let product: String
    public let productId: Int
    public let priority: String
    public let priorityCode: String
    public let shortName: String
    public let kmDzoFullName: String
    public let kmDzoId: Int
    public let holdingName: String
    public let refuseReason: String
    public let refuseReasonCode: String
    public let refuseDescription: String
    public let source: String
    public let sourceCode: String
}
