//
//  ContactEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class ContactEntity {
    
    var id: String
    var name: String
    var surname: String
    var patronymic: String?
    var dealId: String?
    var position: String?
    var phone: String?
    var mail: String?
    var comment: String?

    init(id: String, name: String, surname: String, patronymic: String?, position: String?, phone: String?, mail: String?, comment: String?) {
        self.id = id
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.position = position
        self.phone = phone
        self.mail = mail
        self.comment = comment
    }
}
