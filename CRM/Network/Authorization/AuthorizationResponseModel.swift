//
//  AuthorizationResponseModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public struct AuthorizationResponseModel: ResponseProtocol {
    
    public var httpStatusCode: Int?
    public let data: UserDataResponseModel?
    public let errors: ErrorResponseModel?
}

// MARK: - UserData

public struct UserDataResponseModel: Codable {
    public let id: Int?
    public let dzoId: Int?
    public let isChangePass: Bool?
    public let name: String?
    public let role: [String]?
}

public struct ErrorResponseModel: Codable {
    public let pass: String?
    public let login: String?
}

public protocol UserResponseModelProtocol {
    var data: UserDataResponseModel? { get }
}
