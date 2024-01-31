//
//  CacheStorage.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

final class CacheStorage: CacheStorageProtocol {

    typealias Entity = EventData

    private var items: [Entity] = []

    var storageCount: Int { items.count }

    func entities() -> [Entity] {
        return items
    }

    func add(_ entities: [Entity]) {
        items.append(contentsOf: entities)
    }

    func removeAll() {
        items.removeAll()
    }
}
