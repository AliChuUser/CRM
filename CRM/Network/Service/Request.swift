//
//  Request.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class Request: RequestProtocol {
    public var endPoint: String
    public var method: RequestMethod
    public var header: Header?
    public var dataModel: Encodable?
    
    public init(endPoint: String, method: RequestMethod, header: Header?, dataModel: Encodable?) {
        self.endPoint = endPoint
        self.method = method
        self.header = header
        self.dataModel = dataModel
    }
}
