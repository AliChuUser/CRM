//
//  CacheStorageProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

protocol CacheStorageProtocol {

    typealias Entity = EventData

    /// Кол-во объектов в хранилище
    var storageCount: Int { get }

    /// Получить все объекты из хранилища
    ///
    /// - Returns: массив объектов.
    func entities() -> [Entity]

    /// Добавить набор сущностей в хранилище.
    ///
    /// - Parameter entity: Набор сущностей, которые необходимо добавить в хранилище.
    func add(_ entities: [Entity])

    /// Удалить все объекты из хранилища
    func removeAll()
}
