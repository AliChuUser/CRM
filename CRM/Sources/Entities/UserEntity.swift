//
//  UserEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

struct UserEntity {
    let id: Int
    let dzoId: Int
    let isChangePass: Bool
    let name: String
    let role: [String]
}

extension UserEntity {
    init?(model: UserResponseModelProtocol) {
        guard
            let id = model.data?.id,
            let dzoId = model.data?.dzoId,
            let isChangePass = model.data?.isChangePass,
            let name = model.data?.name,
            let role = model.data?.role
        else { return nil }
        
        self.id = id
        self.dzoId = dzoId
        self.isChangePass = isChangePass
        self.name = name
        self.role = role
    }
}
