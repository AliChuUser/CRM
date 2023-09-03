//
//  ListRequestModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

// MARK: - ListRequestModel
public struct ListRequestModel: Encodable {
    public let paging: Paging
    public var filter: [Filter]?
    public var sort: [Sort]?
    
    public init(paging: Paging,
                filter: [Filter]? = nil,
                sort: [Sort]? = nil
    ) {
        self.paging = paging
        if let filter = filter { self.filter = filter }
        if let sort = sort { self.sort = sort }
    }
}

// MARK: - Filter
public struct Filter: Encodable {
    
    public var field: String
    public var operation: String
    public var value: AnyEncodable
    
    private init(field: String, operation: String, value: AnyEncodable) {
        self.field = field
        self.operation = operation
        self.value = value
    }
    
    public init(field: String, operation: String, value: Int) {
        self.init(field: field, operation: operation, value: AnyEncodable(value))
    }
    
    public init(field: String, operation: String, value: String) {
        self.init(field: field, operation: operation, value: AnyEncodable(value))
    }
    
    public init(field: String, operation: String, value: [String]) {
        self.init(field: field, operation: operation, value: AnyEncodable(value))
    }
    
    public init(field: String, operation: String, value: [Int]) {
        self.init(field: field, operation: operation, value: AnyEncodable(value))
    }
}

public struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

// MARK: - Sort
public struct Sort: Encodable {
    public let order: Int
    public let field: String
    public let operation: String
    
    public init(order: Int, field: String, operation: String) {
        self.order = order
        self.field = field
        self.operation = operation
    }
}

// MARK: - Paging
public struct Paging: Encodable {
    public let pageNum: Int
    public let itemsPerPage: Int
    
    public init(pageNum: Int, itemsPerPage: Int) {
        self.pageNum = pageNum
        self.itemsPerPage = itemsPerPage
    }
}
