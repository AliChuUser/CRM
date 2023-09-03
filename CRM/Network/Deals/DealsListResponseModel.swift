//
//  DealsListResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Deals List Response Model
public struct DealsListResponseModel: ResponseProtocol {
     public let data: [DealResponseModel]
        // let commonErrors: [JSONAny]
    }


// MARK: - Deal Response Model
public struct DealResponseModel: Decodable {
    public let id: Int
    public let priorityCode: DealPriorityCodeModel
    public let shortName: String
    public let product: String
    public let statusCode: DealStatusCodeModel
}

// MARK: - Deal Priority Model
public enum DealPriorityCodeModel: String, Decodable {
    case low = "low"
    case middle = "middle"
    case high = "high"
    case notAvailable = "not_available"
}

// MARK: - Deal Status Model
public enum DealStatusCodeModel: String, RawRepresentable, Decodable {
    case free = "1_free" // Свободный
    case inWorkBank = "2_in_work_bank" //  В работе у банка
    case agreementBank = "3_agreement_bank" // Согласие
    case refusalBank = "4_refusal_bank" // Отказ банка
    case hold = "5_hold" // Hold
    case inWorkDzo = "6_in_work" // В работе
    case agreementDzo = "7_agreement" // Согласие
    case decorBergain = "7_1_decor_bargain" // Оформление сделки
    case refusalDzo = "8_refusal_dzo" // Отказ
    case bergain = "9_bargain" // Сделка
    case archive = "10_archive" // Архив
    
    public init(from decoder: Decoder) throws {
        let registered = try decoder.singleValueContainer().decode(String.self)
        self = DealStatusCodeModel(rawValue: registered) ?? .inWorkBank
    }
    
}
