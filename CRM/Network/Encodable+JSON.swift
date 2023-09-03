//
//  Encodable+JSON.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
