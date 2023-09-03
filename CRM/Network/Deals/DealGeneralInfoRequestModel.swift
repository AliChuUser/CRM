//
//  DealGeneralInfoRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Deal General Info Request Model
public struct DealGeneralInfoRequestModel: Encodable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
