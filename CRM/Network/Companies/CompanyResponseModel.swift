//
//  CompanyResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Company Short Response Model
public struct CompanyShortResponseModel: ResponseProtocol {
     public let data: CompanyModel
//     let commonErrors: [JSONAny]
}

// MARK: - Company Full Response Model
public struct CompanyFullResponseModel: ResponseProtocol {
     public let data: FullCompanyModel
//     let commonErrors: [JSONAny]
}

// MARK: - Company Model
public struct CompanyModel: Decodable {
    public let shortName: String
    public let inn: String
    public let kpp: String
    public let customerType: String
    public let customerTypeCode: String
    public let holdingName: String
    public let allProspect: Int
    public let openProspect: Int
    public let sucessProspect: Int
    public let failProspect: Int
}

// MARK: - Full Company Model
public struct FullCompanyModel: Decodable {
    public let name: String
    public let shortName: String
    public let inn: String
    public let kpp: String
    public let holdingName: String
    public let customerType: String
    public let customerTypeCode: String
    public let segment: String
    public let territorialBank: String
    public let timeZone: String
    public let kmFullName: String
    public let kmPhone: String
    public let kmEmail: String
    public let tkmFullName: String
    public let tkmPhone: String
    public let tkmEmail: String
    public let crmId: String
    public let updatedDate: String
}
