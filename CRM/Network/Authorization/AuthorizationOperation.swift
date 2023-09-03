//
//  AuthorizationOperation.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class AuthorizationOperation {
    
    let loginEndPoint: String = "v1/auth/signin"
    let logoutEndPoint: String = "v1/auth/logout"
    
    private var service: ServiceProtocol
    
    public init(in service: ServiceProtocol) {
        self.service = service
    }
    
    public func login(username: String,
                      password: String,
                      completion: @escaping (Result<AuthorizationResponseModel, Error>) -> Void) {
        
        let userInfo = "\(username):\(password)"
        guard let userDataInfo = userInfo.data(using: String.Encoding.utf8) else { return }
        let base64UserInfo = userDataInfo.base64EncodedString()
        
        
        let request = Request(endPoint: loginEndPoint, method: .post, header: Header(configurationHeaders: "Basic \(base64UserInfo)", forHTTPHeaderField: "Authorization"), dataModel: nil)
        
        service.execute(request, responseType: AuthorizationResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    public func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Request(endPoint: logoutEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: nil)
        service.execute(request, completion: {
            result in
            switch result {
            case.success(()):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
