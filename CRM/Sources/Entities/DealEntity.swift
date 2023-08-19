//
//  DealEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

enum DealFilter {
    case process
    case refusal
    case closedСontractExecuted
    case new
    
    var stringValue: String {
        switch self {
        case .process:
            return "В работе"
        case .refusal:
            return "В отказе"
        case .closedСontractExecuted:
            return "Заключенные"
        case .new:
            return "Новые"
        }
        
    }
}

enum DealStatus {
    
    case refusal
    case pause
    
    case new
    case inWork
    case preparingCO
    case handlingObjects
    case preparationContract
    case signingContract
    case configuringIntegrations
    case testing
    case successfullyImplemented
    case closedRefused
    case closedСontractExecuted
    
    static var all: [DealStatus] {
        return [.new, .inWork, .preparingCO, .handlingObjects, preparationContract, .signingContract, .configuringIntegrations, .testing, .successfullyImplemented,  .closedСontractExecuted, .closedRefused,]
    }
    
    var stringValue: String {
        switch self {
        case .refusal:
            return "Закрыта/Отказ"
        case .pause:
            return "Пауза"
            
            
        case .new:
            return "Структурирование сделки"
        case .inWork:
            return "Оценка проекта. Подготовка КП"
        case .preparingCO:
            return "Согласование с клиентом"
        case .handlingObjects:
            return "Тендерная процедура"
        case .preparationContract:
            return "Подготовка договора"
        case .signingContract:
            return "Договор подписан/Заключен"
        case .configuringIntegrations:
            return "Реализация проекта"
        case .testing:
            return "Оплата"
        case .successfullyImplemented:
            return "Подтверждение продажи"
        case .closedRefused:
            return "Закрыта/Отказ"
        case .closedСontractExecuted:
            return "Закрыта.Договор исполнен"
        }
    }
}

class DealEntity {
    
    var id: String
    var title: String
    var status: DealStatus
    var filter: DealFilter
    
    // О сделке
    var products: [String]?
    var manager: ContactEntity?
    var amount: Int?
    var updateDate: Date?
    var comment: String?
    
    // Задачи
    var tasks: [TaskEntity]
    var tasksId: [String]?
    // Контакты
    var contacts: [ContactEntity]
    
    // Об организации
    var company: CompanyEntity
    
    // История
    var history: [String]
    
    init(id: String, title: String, status: DealStatus, filter: DealFilter, company: CompanyEntity, contacts: [ContactEntity], products: [String]?, amount: Int?, comment: String?) {
        self.id = id
        self.title = title
        self.status = status
        self.filter = filter
        self.company = company
        self.contacts = contacts
        self.products = products
        self.amount = amount
        self.comment = comment
        self.tasks = []
        self.tasksId = []
        self.history = []
    }
}
