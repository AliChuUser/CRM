//
//  DiskStorage.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

final class DiskStorage: DiskStorageProtocol {

    typealias Entity = EventData

    enum StorageEnvironment: String {
        case test = "Test"
        case prom = "Tracker"
    }

    /// Кол-во дней хранения в хранилище
    var limitDiskDaysEvents: Int? {
        didSet {
            if let days = limitDiskDaysEvents {
                let timeInterval = TimeInterval(days)
                expiration = .days(timeInterval)
            }
        }
    }
    /// Тип хранилища на диске - test / prom (folder name in File store)
    let storageEnvironment: StorageEnvironment
    /// Срок хранения объектов в хранилище
    var expiration: Expiration

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    private var manager = FileManager.default

    required init(storageEnvironment: StorageEnvironment = .prom, expiration: Expiration = .never) {
        self.expiration = expiration
        self.storageEnvironment = storageEnvironment
    }

    /// Добавить объект в хранилище
    ///
    /// - Parameter entity: объект
    /// - Throws: FileManager or JSON encoding error.
    func add(_ entity: Entity) throws {
        let url = try storeURL()
        let data = try encoder.encode(entity)
        try manager.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)

        let path = try fileURL(entity: entity).path
        manager.createFile(atPath: path, contents: data, attributes: nil)

        let attributes: [FileAttributeKey: Any] = [
            .creationDate: Date(),
            .modificationDate: expiration.date
        ]

        try manager.setAttributes(attributes, ofItemAtPath: path)
    }

    /// Добавить массив объектов в хранилище
    ///
    /// - Parameter entities: массив объектов.
    /// - Throws: FileManager or JSON encoding error.
    func add(_ entities: [Entity]) throws {
        try entities.forEach { try add($0) }
    }

    /// Получить объект по его id из хранилища
    ///
    /// - Parameter id: id объекта.
    /// - Returns: объект.
    func fetchEntity(withId id: String) -> Entity? {
        return entity(withIdString: "\(id)")
    }

    /// Получить массив объектов из хранилища по заданному массиву идентификаторов
    ///
    /// - Parameter ids: массив ids.
    /// - Returns: массив объектов.
    func fetchEntities(withIds ids: [String]) -> [Entity] {
        return ids.compactMap { fetchEntity(withId: $0) }
    }

    /// Получить массив объектов из хранилища с заданным лимитом
    ///
    /// - Parameter fetchLimit: кол-во запрашиваемых объектов
    /// - Returns: массив объектов.
    func fetchEntities(fetchLimit: Int) -> [Entity] {
        return Array(entities().prefix(fetchLimit))
    }

    /// Получить все объекты из хранилища
    ///
    /// - Returns: массив объектов.
    func entities() -> [Entity] {
        guard let url = try? storeURL() else { return [] }
        guard let ids = try? manager.contentsOfDirectory(atPath: url.path) else { return [] }
        return ids.compactMap { entity(withIdString: $0) }
    }

    /// Удалить объект по его id из хранилища
    ///
    /// - Parameter id: id объекта.
    func remove(withId id: String) throws {
        guard let url = try? fileURL(id: id) else { return }
        guard manager.fileExists(atPath: url.path) else { return }
        try? manager.removeItem(at: url)
    }

    /// Удалить объекты из хранилища по заданному массиву идентификаторов
    ///
    /// - Parameter ids: массив ids.
    func remove(withIds ids: [String]) throws {
        try ids.forEach { try remove(withId: $0) }
    }

    /// Удалить все объекты из хранилища
    func removeAll() {
        guard let url = try? storeURL() else { return }
        guard manager.fileExists(atPath: url.path) else { return }
        try? manager.removeItem(at: url)
    }

    /// Кол-во объектов в хранилище
    var storageCount: Int {
        guard let url = try? storeURL() else { return 0 }
        guard let items = try? manager.contentsOfDirectory(atPath: url.path) else { return 0 }
        return items.count
    }

}

// MARK: - Helpers

private extension DiskStorage {

    /// Получить объект из хранилща по его  id.
    ///
    /// - Parameter id: id объекта.
    /// - Returns: объект.
    func entity(withIdString idString: String) -> Entity? {
        guard let path = try? fileURL(idString: idString).path else { return nil }
        guard let attributes = try? manager.attributesOfItem(atPath: path) else { return nil }
        guard let modificationDate = attributes[.modificationDate] as? Date else { return nil }
        guard modificationDate >= Date() else {
            if let url = try? fileURL(idString: idString), manager.fileExists(atPath: url.path) {
                try? manager.removeItem(at: url)
            }
            return nil
        }
        guard let data = manager.contents(atPath: path) else { return nil }
        return try? decoder.decode(Entity.self, from: data)
    }

    /// URL директории на устройстве для создания хранилища (Documents or Caches)
    ///
    /// - Returns: URL.
    /// - Throws: `FileManager` error
    func documentsURL() throws -> URL {
        let directory: FileManager.SearchPathDirectory
        switch expiration {
        case .never, .days:
            directory = .documentDirectory
        default:
            directory = .cachesDirectory
        }

        return try manager.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    /// URL отдельной папки FilesStore для размещения хранилища
    ///
    /// - Returns: FilesStore URL.
    /// - Throws: `FileManager` error
    func filesStoreURL() throws -> URL {
        return try documentsURL().appendingPathComponent("FilesStore")
    }

    /// URL хранилища.
    ///
    /// - Returns: URL хранилища.
    /// - Throws: `FileManager` error
    func storeURL() throws -> URL {
        return try filesStoreURL().appendingPathComponent(storageEnvironment.rawValue, isDirectory: true)
    }

    /// URL файла (объекта) с определенным  id.
    ///
    /// - Parameter id: id объекта.
    /// - Returns: file URL.
    /// - Throws: `FileManager` error
    func fileURL(id: String) throws -> URL {
        return try fileURL(idString: "\(id)")
    }

    /// URL файла (объекта) с определенным  id - string.
    ///
    /// - Parameter idString: id объекта - string.
    /// - Returns: file URL.
    /// - Throws: `FileManager` error
    func fileURL(idString: String) throws -> URL {
        return try storeURL().appendingPathComponent(idString)
    }

    /// URL файла конкретного объекта
    ///
    /// - Parameter entity: объект.
    /// - Returns: file URL.
    /// - Throws: `FileManager` error
    func fileURL(entity: Entity) throws -> URL {
        return try fileURL(id: entity.id)
    }

}
