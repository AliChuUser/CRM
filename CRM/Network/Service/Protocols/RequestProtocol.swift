//
//  RequestProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public protocol RequestProtocol {
    
    var endPoint: String { get set}
    
    var method: RequestMethod { get set }
    
    var header: Header? { get set }
    
    var dataModel: Encodable? { get set }
}



public enum RequestMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
