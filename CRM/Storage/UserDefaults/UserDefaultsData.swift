//
//  UserDefaultsData.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

final class UserDefaultsData: UserDefaultsDataProtocol {

    private let sdkVersionEnabledKey = "SdkVersionEnabled"
    private let sessionIdKey = "SessionID"

    // MARK: - SDK Version

    var sdkVersionEnabled: Bool? {
        get {
            UserDefaults.standard.bool(forKey: sdkVersionEnabledKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: sdkVersionEnabledKey)
        }
    }

    // MARK: - SessionID

    var sessionID: String? {
        get {
            UserDefaults.standard.string(forKey: sessionIdKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: sessionIdKey)
        }
    }

}
