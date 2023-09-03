//
//  ServiceConfig.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public struct Header: Encodable {
    var configurationHeaders: String
    
    var forHTTPHeaderField: String
}

public class ServiceConfig {
    
    let url = "http://10.36.136.221/"
    
    public init() {}
}
