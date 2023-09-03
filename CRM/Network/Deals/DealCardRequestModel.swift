//
//  DealCardRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - Deal Card Request Model
public struct DealCardRequestModel: Encodable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
