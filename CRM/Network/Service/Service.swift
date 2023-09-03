//
//  Service.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class Service: ServiceProtocol {
    
    public enum ServiceError: LocalizedError {
        case failed
        
        var localizedDescription: String {
            switch self {
            case .failed:
                return "Ошибка при запросе"
            }
        }
    }
    
    private var urlSession: URLSession
    private var baseURL: URL
    
    public init?(configuration: ServiceConfig) {
        self.urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: configuration.url) else {
            return nil
        }
        self.baseURL = url
    }
    
    public func execute<T: ResponseProtocol>(_ request: RequestProtocol, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = baseURL.appendingPathComponent(request.endPoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let requestHeaderConfiguration = request.header?.configurationHeaders, let requestforHTTPHeaderField = request.header?.forHTTPHeaderField {
            urlRequest.setValue(requestHeaderConfiguration, forHTTPHeaderField: requestforHTTPHeaderField)
        }
        urlRequest.httpBody = request.dataModel?.toJSONData()
        
        urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            let error = error ?? ServiceError.failed //ServiceError.failed
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if httpResponse.statusCode != 200 {
                completion(.failure(error))
            } else {
                guard let data = data else {
                    completion(.failure(error))
                    return
                }
                do {
                    guard let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
                    print("Ответ при запросе: ", dataString)
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
        }).resume()
    }
    
    // для запросов, в ответе которых нет data
    public func execute(_ request: RequestProtocol, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(request.endPoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let requestHeaderConfiguration = request.header?.configurationHeaders, let requestforHTTPHeaderField = request.header?.forHTTPHeaderField {
            urlRequest.setValue(requestHeaderConfiguration, forHTTPHeaderField: requestforHTTPHeaderField)
        }
        
        urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }).resume()
    }
}
