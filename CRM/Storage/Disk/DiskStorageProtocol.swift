//
//  DiskStorageProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

protocol DiskStorageProtocol {

    typealias Entity = EventData

    /// Кол-во объектов в хранилище
    var storageCount: Int { get }

    /// Кол-во дней хранения в хранилище
    var limitDiskDaysEvents: Int? { get set }
    /// Добавить объект в хранилище
    ///
    /// - Parameter entity: объект
    /// - Throws: FileManager or JSON encoding error.
    func add(_ entity: Entity) throws

    /// Добавить массив объектов в хранилище
    ///
    /// - Parameter entities: массив объектов.
    /// - Throws: FileManager or JSON encoding error.
    func add(_ entities: [Entity]) throws

    /// Получить объект по его id из хранилища
    ///
    /// - Parameter id: id объекта.
    /// - Returns: объект.
    func fetchEntity(withId id: String) -> Entity?

    /// Получить массив объектов из хранилища по заданному массиву идентификаторов
    ///
    /// - Parameter ids: массив ids.
    /// - Returns: массив объектов.
    func fetchEntities(withIds ids: [String]) -> [Entity]

    /// Получить массив объектов из хранилища с заданным лимитом
    ///
    /// - Parameter fetchLimit: кол-во запрашиваемых объектов
    /// - Returns: массив объектов.
    func fetchEntities(fetchLimit: Int) -> [Entity]

    /// Получить все объекты из хранилища
    ///
    /// - Returns: массив объектов.
    func entities() -> [Entity]

    /// Удалить объект по его id из хранилища
    ///
    /// - Parameter id: id объекта.
    func remove(withId id: String) throws

    /// Удалить объекты из хранилища по заданному массиву идентификаторов
    ///
    /// - Parameter ids: массив ids.
    func remove(withIds ids: [String]) throws

    /// Удалить все объекты из хранилища
    func removeAll()
}
