//
//  CompaniesListResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Companies List Response Model
public struct CompaniesListResponseModel: ResponseProtocol {
     public let data: [CompanyListItemModel]
//     let commonErrors: [JSONAny]
}

// MARK: - Company List Item Model
public struct CompanyListItemModel: Decodable {
    public let inn: String
    public let kpp: String
    public let name: String
    public let shortName: String
    public let segment: String
    public let customerType: String
    public let customerTypeCode: String
    public let holdingName: String
    public let holdingId: String
    public let kmFullName: String
    public let kmPhone: String
    public let kmEmail: String
    public let tkmFullName: String
    public let tkmPhone: String
    public let tkmEmail: String
    public let territorialBank: String
    public let timeZone: String
    public let id: Int
    public let crmId: String
    public let createdDate: String
    public let createdBy: String
    public let updatedDate: String
    public let updatedBy: String
//    ToDo (04.12.2019): Актуализировать наименование полей с Адресом, Телефоном и Вебсайтом компании, когда они будут приходить в списке с бэка.
    public let address: String?
    public let phone: String?
    public let website: String?
}
