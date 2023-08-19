//
//  DealService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class DealService {
    
    private (set) var deals: [DealEntity] = {
        
        var organization10 = CompanyEntity(holdingName: "ВАЙЛДБЕРРИЗ", fullName: "ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ \"ВАЙЛДБЕРРИЗ\"", inn: "7721546864", kpp: "500301001", address: "Россия, г. Москва", customerType: .LE, segment: .large, phone: "89150742456", mail: nil)
        
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
        
        var task0 = TaskEntity(id: "2109i1290", title: "Подготовить договор для подписания", deadline: Date()+78456, assignor: "mslepkova", assignee: "Петров Иван", status: .inWork, type: .task, priority: .high)
        
        var task1 = TaskEntity(id: "20349856", title: "Создать встречу по изучению проекта", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .free, type: .call, priority: .middle)
        var task2 = TaskEntity(id: "09847536", title: "Подготовить презентацию по проекту", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .call, priority: .high)
        var task3 = TaskEntity(id: "18257463", title: "Позвонить ответственному лицу", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .call, priority: .low)
        var task4 = TaskEntity(id: "63475683", title: "Изучить проект", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .completed, type: .meeting, priority: .middle)
        var task5 = TaskEntity(id: "23547263", title: "Подвести итоги по проекту", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .free, type: .call, priority: .notAvailable)
        var task6 = TaskEntity(id: "09847536", title: "Создать встречу по анализу проекта", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .declined, type: .meeting, priority: .notAvailable)
        
        var contact1 = ContactEntity(id: "83275820165", name: "Филипп", surname: "Долуханов", patronymic: nil, position: "Менеджер", phone: "+7 (888) 455 12 88", mail: nil, comment: nil)
        var contact2 = ContactEntity(id: "342509788", name: "Андрей", surname: "Иванов", patronymic: nil, position: "Менеджер", phone: "+7 (888) 455 12 88", mail: nil, comment: nil)
        var contact3 = ContactEntity(id: "092-148120-39", name: "Всеволод", surname: "Петров", patronymic: nil, position: "Менеджер", phone: "+7 (888) 455 12 88", mail: nil, comment: nil)
        
        var contact4 = ContactEntity(id: "12124124124", name: "Константин", surname: "Морозов", patronymic: "Иванович", position: "Технический клиентский менеджер", phone: "+7 (917) 79 444 09", mail: nil, comment: nil)
        
        var result = [DealEntity]()
        
        var d0 = DealEntity(id: "19244177521268", title: "Сбер Курьер", status: .preparationContract, filter: .process, company: organization10, contacts: [contact2], products: ["Сбер Курьер"], amount: 2500000, comment: "Курьерская доставка товаров заказчика физическим лицам")
        d0.manager = contact4
        d0.updateDate = Date()
        d0.tasks = [task0]
        d0.history = ["Открытие сделки"]
        result.append(d0)
        
        var d1 = DealEntity(id: "38276459", title: "Строительство электростанции", status: .preparationContract, filter: .process, company: organization1, contacts: [contact1, contact2, contact3], products: ["B2C Продукт"], amount: 500000, comment: "Строительство гидроэлектростанции")
        d1.manager = contact1
        d1.updateDate = Date()
        d1.tasks = [task1, task2, task3, task4]
        d1.history = ["Открытие сделки", "Передумывание", "Переобдумывание"]
        result.append(d1)
        
        var d2 = DealEntity(id: "486970", title: "Модернизация центра водных видов спорта", status: .inWork, filter: .process, company: organization2, contacts: [contact2, contact3], products: ["B2B Продукт"], amount: 7500000, comment: "Модернизация центра водных видов спорта")
        d2.manager = contact1
        d2.updateDate = Date()
        d2.tasks = [task1, task2, task3, task4, task5, task6]
        d2.history = ["Открытие сделки", "Передумывание", "Переобдумывание"]
        result.append(d2)
        
        var d3 = DealEntity(id: "4278036", title: "Покупка завода по производству фармацевтической продукции", status: .preparingCO, filter: .process, company: organization3, contacts: [contact1, contact3], products: ["C2C Продукт"], amount: 1000000, comment: "Покупка завода по производству фармацевтической продукции")
        d3.manager = contact1
        d3.updateDate = Date()
        d3.tasks = [task1, task2, task3]
        d3.history = ["Открытие сделки", "Передумывание", "Переобдумывание"]
        result.append(d3)
        
        var d4 = DealEntity(id: "7832965",title: "Строительство животноводческого комплекса", status: .handlingObjects, filter: .process, company: organization4, contacts: [contact1, contact2, contact3], products: ["B2B Продукт", "B2C Продукт"], amount: 1000000, comment: "Строительство животноводческого комплекса")
        d4.manager = contact1
        d4.updateDate = Date()
        d4.tasks = [task1, task2, task3, task4]
        d4.history = ["Открытие сделки", "Передумывание", "Переобдумывание"]
        result.append(d4)
        
        var d5 = DealEntity(id: "32984756", title: "Расширение производства светотехники", status: .closedСontractExecuted, filter: .closedСontractExecuted, company: organization5, contacts: [contact3], products: ["B2C Продукт"], amount: 2000000, comment: "Расширение производства светотехники")
        d5.manager = contact1
        d5.updateDate = Date()
        d5.tasks = [task1, task2, task3, task4, task5, task6]
        d5.history = ["Открытие сделки", "Передумывание", "Переобдумывание"]
        result.append(d5)
        
        var d6 = DealEntity(id: "1927568", title: "Проект по строительству сети отелей", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 9000000, comment: "Проект по строительству сети отелей")
        d6.manager = contact1
        d6.updateDate = Date()
        d6.tasks = [task1, task2, task3, task4, task5]
        d6.history = ["Открытие сделки", "Передумывание", "Переобдумывание"]
        result.append(d6)
        
        var d7 = DealEntity(id: "19232427568", title: "Закупка оборудования", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 5000000, comment: "Закупка оборудования")
        d7.manager = contact1
        d7.updateDate = Date()
        d7.tasks = [task1, task2, task3, task4, task5]
        d7.history = ["Открытие сделки"]
        result.append(d7)
        
        var d8 = DealEntity(id: "19217742748324568", title: "Заявка на участие в аукционе", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Заявка на участие в аукционе")
        d8.manager = contact2
        d8.updateDate = Date()
        d8.tasks = [task1, task2, task3, task4, task5]
        d8.history = ["Открытие сделки"]
        result.append(d8)
        
        var d9 = DealEntity(id: "192172342347568", title: "Кредит на расширение производства", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Кредит на расширение производства")
        d9.manager = contact2
        d9.updateDate = Date()
        d9.tasks = [task1, task2, task3, task4, task5]
        d9.history = ["Открытие сделки"]
        result.append(d9)
        
        var d10 = DealEntity(id: "19123452177568", title: "Капитальный ремонт помещений", status: .new, filter: .process, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Капитальный ремонт помещений")
        d10.manager = contact2
        d10.updateDate = Date()
        d10.tasks = [task1, task2, task3, task4, task5]
        d10.history = ["Открытие сделки"]
        result.append(d10)
        
        var d11 = DealEntity(id: "192177568", title: "Разработка проектной документации", status: .new, filter: .process, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Разработка проектной документации")
        d11.manager = contact2
        d11.updateDate = Date()
        d11.tasks = [task1, task2, task3, task4, task5]
        d11.history = ["Открытие сделки"]
        result.append(d11)
        
        var d12 = DealEntity(id: "1921770047568", title: "Поставка расходных материалов", status: .preparingCO, filter: .process, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Поставка расходных материалов")
        d12.manager = contact2
        d12.updateDate = Date()
        d12.tasks = [task1, task2, task3, task4, task5]
        d12.history = ["Открытие сделки"]
        result.append(d12)
        
        var d13 = DealEntity(id: "1921247177568", title: "Услуги в области защиты информации по аттестации объектов информатизации", status: .preparingCO, filter: .process, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Услуги в области защиты информации по аттестации объектов информатизации")
        d13.manager = contact2
        d13.updateDate = Date()
        d13.tasks = [task1, task2, task3, task4, task5]
        d13.history = ["Открытие сделки"]
        result.append(d13)
        
        var d14 = DealEntity(id: "1921987255477568", title: "Выполнение работ по благоустройству территории объекта", status: .new, filter: .process, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Выполнение работ по благоустройству территории объекта")
        d14.manager = contact2
        d14.updateDate = Date()
        d14.tasks = [task1, task2, task3, task4, task5]
        d14.history = ["Открытие сделки"]
        result.append(d14)
        
        var d27 = DealEntity(id: "1921987255411177568", title: "Поставка расходных материалов", status: .new, filter: .process, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 2000000, comment: "Поставка расходных материалов")
        d27.manager = contact2
        d27.updateDate = Date()
        d27.tasks = [task1, task2, task3, task4, task5]
        d27.history = ["Открытие сделки"]
        result.append(d27)
        
        var d15 = DealEntity(id: "192675177568", title: "Поставка многофункциональных устройств для нужд министерства", status: .closedСontractExecuted, filter: .closedСontractExecuted, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "поставка многофункциональных устройств для нужд министерства")
        d15.manager = contact2
        d15.updateDate = Date()
        d15.tasks = [task1, task2, task3, task4, task5]
        d15.history = ["Открытие сделки"]
        result.append(d15)
        
        var d16 = DealEntity(id: "190982177568", title: "Оказание услуг по экспертизе промышленной безопасности", status: .closedСontractExecuted, filter: .closedСontractExecuted, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 2000000, comment: "Оказание услуг по экспертизе промышленной безопасности")
        d16.manager = contact2
        d16.updateDate = Date()
        d16.tasks = [task1, task2, task3, task4, task5]
        d16.history = ["Открытие сделки"]
        result.append(d16)
        
        var d17 = DealEntity(id: "192172137568", title: "Проектно-изыскательские работы и экспертиза проекта ", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Проектно-изыскательские работы и экспертиза проекта ")
        d17.manager = contact2
        d17.updateDate = Date()
        d17.tasks = [task1, task2, task3, task4, task5]
        d17.history = ["Открытие сделки"]
        result.append(d17)
        
        var d18 = DealEntity(id: "19217587568", title: "Установка и ввод в эксплуатацию оборудования", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 500000, comment: "Заявка на участие в аукционе")
        d18.manager = contact2
        d18.updateDate = Date()
        d18.tasks = [task1, task2, task3, task4, task5]
        d18.history = ["Открытие сделки"]
        result.append(d18)
        
        var d19 = DealEntity(id: "19219877568", title: "Выполнение ремонтных работ в рамках государственной программы", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 500000, comment: "Заявка на участие в аукционе")
        d19.manager = contact2
        d19.updateDate = Date()
        d19.tasks = [task1, task2, task3, task4, task5]
        d19.history = ["Открытие сделки"]
        result.append(d19)
        
        var d20 = DealEntity(id: "19213377568", title: "Закупка оборудования", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 500000, comment: "Закупка оборудования")
        d20.manager = contact2
        d20.updateDate = Date()
        d20.tasks = [task1, task2, task3, task4, task5]
        d20.history = ["Открытие сделки"]
        result.append(d20)
        
        var d21 = DealEntity(id: "19217754568", title: "Кредит", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 500000, comment: "Кредит")
        d21.manager = contact2
        d21.updateDate = Date()
        d21.tasks = [task1, task2, task3, task4, task5]
        d21.history = ["Открытие сделки"]
        result.append(d21)
        
        var d22 = DealEntity(id: "1992177568", title: "Строительство дома", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 500000, comment: "Строительство дома")
        d22.manager = contact2
        d22.updateDate = Date()
        d22.tasks = [task1, task2, task3, task4, task5]
        d22.history = ["Открытие сделки"]
        result.append(d22)
        
        var d23 = DealEntity(id: "1192172357568", title: "Лизинг", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 500000, comment: "Лизинг")
        d23.manager = contact2
        d23.updateDate = Date()
        d23.tasks = [task1, task2, task3, task4, task5]
        d23.history = ["Открытие сделки"]
        result.append(d23)
        
        var d24 = DealEntity(id: "192170744568", title: "Ремонт дороги", status: .new, filter: .new, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1000000, comment: "Ремонт дороги")
        d24.manager = contact2
        d24.updateDate = Date()
        d24.tasks = [task1, task2, task3, task4, task5]
        d24.history = ["Открытие сделки"]
        result.append(d24)
        
        
        
        var d25 = DealEntity(id: "1992177224568", title: "Строительство дома", status: .refusal, filter: .refusal, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1900000, comment: "Строительство дома")
        d25.manager = contact2
        d25.updateDate = Date()
        d25.tasks = [task1, task2, task3, task4, task5]
        d25.history = ["Открытие сделки"]
        result.append(d25)
        
        var d26 = DealEntity(id: "1192245235177568", title: "Лизинг", status: .refusal, filter: .refusal, company: organization2, contacts: [contact2], products: ["B2B Продукт"], amount: 1900000, comment: "Лизинг")
        d26.manager = contact2
        d26.updateDate = Date()
        d26.tasks = [task1, task2, task3, task4, task5]
        d26.history = ["Открытие сделки"]
        result.append(d26)
        
        
        return result
    }()
    
    var updateHandlers = [() -> Void]()
    
    
    func addDeal(deal: DealEntity) {
        deals.append(deal)
        notify()
    }
    
    func addTaskToDeal(task: TaskEntity) {
        deals.forEach { deal in
            if deal.id == task.dealId {
                deal.tasks.append(task)
            }
        }
        notify()
    }
    
    func addContactToDeal(contact: ContactEntity) {
        deals.forEach { deal in
            if deal.id == contact.dealId {
                deal.contacts.append(contact)
            }
        }
        notify()
    }
    
    func removeDeal(deal: DealEntity) {
        deals.removeAll(where: { $0.id == deal.id })
        notify()
    }
    
    private func notify() {
        updateHandlers.forEach { $0() }
    }
}
