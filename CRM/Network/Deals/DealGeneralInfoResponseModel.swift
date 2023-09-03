//
//  DealGeneralInfoResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Deal General Info Response Model
public struct DealGeneralInfoResponseModel: ResponseProtocol {
     public let data: DealGeneralInfoModel
//     let commonErrors: [JSONAny]
}

// MARK: - Deal General Info Model
public struct DealGeneralInfoModel: Decodable {
    public let id: Int
    public let dzoName: String
    public let dzoID: Int
    public let name: String
    public let shortName: String
    public let customerID: Int
    public let inn: String
    public let kpp: String
    public let segment: String
    public let customerType: String
    public let customerTypeCode: String
    public let product: String
    public let productID: Int
    public let holdingID: String
    public let holdingName: String
    public let territorialBank: String
    public let timeZone: String
    public let refuseReason: String
    public let refuseReasonCode: String
    public let refuseDescription: String
    public let descriprtion: String
    public let created: String
    public let lastUpd: String
    public let loadUpdated: String
}
