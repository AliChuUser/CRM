//
//  ContactService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class ContactService {
    
    private (set) var contacts: [ContactEntity] = [
        ContactEntity(id: "374856", name: "Петр", surname: "Иванов", patronymic: nil, position: "Тестеровщик", phone: "+7 818 444 19 08", mail: nil, comment: nil),
        ContactEntity(id: "73462573", name: "Дмитрий", surname: "Косов", patronymic: nil, position: "Разработчик", phone: "+7 884 465 52 78", mail: nil, comment: nil),
        ContactEntity(id: "8945760845967", name: "Александр", surname: "Маланин", patronymic: nil, position: "Разработчик", phone: "+7 883 499 22 81", mail: nil, comment: nil),
        ContactEntity(id: "384756973824657", name: "Анна", surname: "Мишутина", patronymic: nil, position: "Тестеровщик", phone: "+7 881 975 92 11", mail: nil, comment: nil),
        ContactEntity(id: "871265978235", name: "Станислав", surname: "Демидов", patronymic: nil, position: "Разработчик", phone: "+7 890 544 11 12", mail: nil, comment: nil),
        ContactEntity(id: "38247659872345", name: "Антон", surname: "Сухарев", patronymic: nil, position: "Разработчик", phone: "+7 838 225 72 54", mail: nil, comment: nil),
        ContactEntity(id: "2571452613", name: "Евгений", surname: "Мишин", patronymic: nil, position: "Тестеровщик", phone: "+7 898 432 77 89", mail: nil, comment: nil),
        ContactEntity(id: "453764856y", name: "Денис", surname: "Долгов", patronymic: nil, position: "Разработчик", phone: "+7 818 151 12 18", mail: nil, comment: nil),
        ContactEntity(id: "546y45u768453674856", name: "Илья", surname: "Старцев", patronymic: nil, position: "Разработчик", phone: "+7 888 455 12 88", mail: nil, comment: nil),
        ContactEntity(id: "4586738291995y",name: "Олег", surname: "Немов", patronymic: nil, position: "Тестеровщик", phone: "+7 898 499 19 83", mail: nil, comment: nil)
    ]
    
    var updateHandlers = [() -> Void]()
    
    func addContact(contact: ContactEntity) {
        contacts.append(contact)
        notify()
    }
    
    func removeContact(contact: ContactEntity) {
        // TODO: 23.01.2020 repalce by id
        contacts.removeAll(where: { $0.name == contact.name})
        notify()
    }
    
    private func notify() {
        updateHandlers.forEach { $0() }
    }
    
}
