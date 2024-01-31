//
//  UserDefaultsDataProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

protocol UserDefaultsDataProtocol {

    var sdkVersionEnabled: Bool? { get set }

    var sessionID: String? { get set }
}
