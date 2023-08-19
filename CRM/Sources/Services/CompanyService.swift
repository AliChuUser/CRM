//
//  CompanyService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class CompanyService {
    
    private (set) var companies: [CompanyEntity] = {
        var organization1 = CompanyEntity(holdingName: "Траст Холдинг", fullName: "Европейский Финансовый Альянс", inn: "5664079397", kpp: "333222123", address: "Россия, г. Новосибирск", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization1.website = "www.telegram.com"
        
        var organization2 = CompanyEntity(holdingName: "Новороссийский морской торговый фонд", fullName: "Новороссийский морской торговый фонд", inn: "5664079397", kpp: "333222123", address: "Россия, г. Москва", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization2.website = "www.telegram.com"
        
        var organization3 = CompanyEntity(holdingName: "Global Trans Atlantic", fullName: "Global Trans Atlantic", inn: "5664079397", kpp: "333222123", address: "Россия, г. Москва", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization3.website = "www.telegram.com"
        
        var organization4 = CompanyEntity(holdingName: "Стройсервис", fullName: "Стройсервис", inn: "5664079397", kpp: "5664079397", address: "Россия, г. Москва", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization4.website = "www.telegram.com"
        
        var organization5 = CompanyEntity(holdingName: "Европейский Финансовый Альянс", fullName: "Европейский Финансовый Альянс", inn: "5664079397", kpp: "333222123", address: "Россия, г. Москва", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization5.website = "www.telegram.com"
        
        var organization6 = CompanyEntity(holdingName: "ГК Днепр", fullName: "ГК Днепр", inn: "5664079397", kpp: "5664079397", address: "Россия, г. Ульяновск", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization4.website = "www.telegram.com"
        
        var organization7 = CompanyEntity(holdingName: "ПБК", fullName: "ПБК", inn: "5664079397", kpp: "333222123", address: "Россия, г. Ростов-на-Дону", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization5.website = "www.telegram.com"
        
        var organization8 = CompanyEntity(holdingName: "Нева", fullName: "Нева", inn: "5664079397", kpp: "333222123", address: "Россия, г. Москва", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization5.website = "www.telegram.com"
        
        var organization9 = CompanyEntity(holdingName: "ГК \"Бриз\"", fullName: "ГК Днепр", inn: "5664079397", kpp: "5664079397", address: "Россия, г. Москва", customerType: CompanyCustomerType.LE, segment: CompanySegment.middle, phone: "89150742456", mail: "mail@google.com")
        organization4.website = "www.telegram.com"
        
        var organization10 = CompanyEntity(holdingName: "ВАЙЛДБЕРРИЗ", fullName: "ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ \"ВАЙЛДБЕРРИЗ\"", inn: "7721546864", kpp: "500301001", address: "Россия, г. Москва", customerType: .LE, segment: .large, phone: "89150742456", mail: nil)
        organization10.website = "-"
        
        return [organization10, organization1, organization2, organization3, organization4, organization5, organization6, organization7, organization8, organization9]
    }()
    
    var updateHandlers = [() -> Void]()
    
    func addCompany(company: CompanyEntity) {
        companies.append(company)
        notify()
    }
    
    func removeCompany(company: CompanyEntity) {
        // TODO: 23.01.2020 repalce by id
        companies.removeAll(where: { $0.holdingName == company.holdingName })
        notify()
    }
    
    private func notify() {
        updateHandlers.forEach { $0() }
    }
}
