//
//  NLPConfiguration.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class NLPConfiguration: WebSocketConfigurationProtocol {

    public let url: URL

    public var sslValidationEnabled: Bool {
        return false
    }

    public var connectionCloseTimeout: TimeInterval {
        return 10
    }
    
    public init(url: URL) {
        self.url = url
    }
}
