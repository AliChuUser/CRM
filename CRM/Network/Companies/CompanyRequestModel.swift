//
//  CompanyRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Company Request Model
public struct CompanyRequestModel: Encodable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
