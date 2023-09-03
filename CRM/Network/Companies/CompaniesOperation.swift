//
//  CompaniesOperation.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class CompaniesOperation {
    
    let companiesListEndPoint: String = "v1/customers/list"
    let companyInfoEndPoint: String = "v1/customers/info"
    let companyFullEndPoint: String = "v1/customers/show"
    let companyChangeHistoryEndPoint: String = "v1/organization/list"
    let companyCommentsListEndPoint: String = "v1/customers/comments/list"
    let companyAddCommentEndPoint: String = "v1/customers/comments/create"
    let companyEditCommentEndPoint: String = "v1/customers/comments/update"
    
    private var service: ServiceProtocol
    
    public init(in service: ServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Список организаций
    public func getList(dataModel: ListRequestModel,
                        completion: @escaping (Result<CompaniesListResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companiesListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompaniesListResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Карточка организации
    public func getCompanyInfo(dataModel: CompanyRequestModel,
                        completion: @escaping (Result<CompanyShortResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companyInfoEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompanyShortResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Карточка организации (Общая информация)
    public func getCompanyFull(dataModel: CompanyRequestModel,
                        completion: @escaping (Result<CompanyFullResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companyFullEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompanyFullResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - История изменения организации
    public func getChangeHistory(dataModel: ListRequestModel,
                        completion: @escaping (Result<CompanyChangeHistoryResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companyChangeHistoryEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompanyChangeHistoryResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Список заметок организации
    public func getCommentsList(dataModel: CompanyCommentsListRequestModel,
                        completion: @escaping (Result<CompanyCommentsListResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companyCommentsListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompanyCommentsListResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Добавление заметки к организации
    public func addComment(dataModel: AddCompanyCommentRequestModel,
                        completion: @escaping (Result<CompanyCommentResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companyAddCommentEndPoint, method: .put, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompanyCommentResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Редактирование заметки организации
    public func editComment(dataModel: EditCompanyCommentRequestModel,
                        completion: @escaping (Result<CompanyCommentResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: companyEditCommentEndPoint, method: .patch, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompanyCommentResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
