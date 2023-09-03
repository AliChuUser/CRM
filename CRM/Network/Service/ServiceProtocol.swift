//
//  ServiceProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public protocol ServiceProtocol {
   
    func execute<T: ResponseProtocol>(_ request: RequestProtocol, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    
    func execute(_ request: RequestProtocol, completion: @escaping (Result<Void, Error>) -> Void)
}
