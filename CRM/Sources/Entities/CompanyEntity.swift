//
//  CompanyEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

enum CompanyCustomerType: String {
    case none = "Не заполнено"
    case IE = "ИП"
    case LE = "Юридическое лицо"
    
    static var all: [CompanyCustomerType] {
        return [.IE, .LE]
    }
}

enum CompanySegment: String {
    case none = "Не заполнено"
    case small = "Малый"
    case middle = "Средний"
    case large = "Крупный"
    
    static var all: [CompanySegment] {
        return [.small, .middle, .large]
    }
}

class CompanyEntity {
    var holdingName: String
    var fullName: String
    var inn: String
    var kpp: String
    var address: String?
    var customerType: CompanyCustomerType?
    var segment: CompanySegment?
    //    ToDo (04.12.2019): Актуализировать наименование полей с Адресом, Телефоном и Вебсайтом компании, когда они будут приходить в списке с бэка.
    var phone: String?
    var mail: String?
    var website: String?

    init(holdingName: String, fullName: String, inn: String, kpp: String, address: String?, customerType: CompanyCustomerType?, segment: CompanySegment?, phone: String?, mail: String?) {
        self.holdingName = holdingName
        self.fullName = fullName
        self.inn = inn
        self.kpp = kpp
        self.address = address
        self.customerType = customerType
        self.segment = segment
        self.phone = phone
        self.mail = mail
    }
}
