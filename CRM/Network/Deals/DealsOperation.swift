//
//  DealsOperation.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class DealsOperation {
    
    let dealsListEndPoint: String = "/v1/prospects/list"
    let createDealEndPoint: String = "/v1/prospects/create"
    let updateDealStatusEndPoint: String = "/v1/prospects/update"
    let dealCardEndPoint: String = "/v1/prospects/info"
    let dealGeneralInfoEndPoint: String = "/v1/prospects/show"
    let dealStatusChangeHistoryEndPoint: String = "v1/prospects/history/list"
    let dealCommentsListEndPoint: String = "v1/prospects/comments/list"
    let addDealCommentEndPoint: String = "v1/prospects/comments/create"
    let editDealCommentEndPoint: String = "v1/prospects/comments/update"
    let deleteDealCommentEndPoint: String = "v1/prospects/comments/update"
    
    private var service: ServiceProtocol
    
    public init(in service: ServiceProtocol) {
        self.service = service
    }

    // MARK: - Просмотр списка сделок
    public func getList(dataModel: ListRequestModel,
                        completion: @escaping (Result<CompaniesListResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: dealsListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CompaniesListResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Создание сделки
    public func create(dataModel: CreateDealRequestModel,
                        completion: @escaping (Result<CreatedDealResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: createDealEndPoint, method: .put, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: CreatedDealResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Изменение статуса сделки / взятие в работу
    public func updateStatus(dataModel: UpdateDealStatusRequestModel,
                        completion: @escaping (Result<UpdateDealStatusResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: updateDealStatusEndPoint, method: .patch, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: UpdateDealStatusResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Карточка сделки - Общая информация (просмотр)
    public func getGeneralInfo(dataModel: DealGeneralInfoRequestModel,
                        completion: @escaping (Result<DealGeneralInfoResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: dealGeneralInfoEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: DealGeneralInfoResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Карточка сделки
    public func getDealCard(dataModel: DealCardRequestModel,
                        completion: @escaping (Result<DealCardResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: dealCardEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: DealCardResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - История изменения статуса сделки
    public func StatusChangeHistory(dataModel: DealStatusChangeHistoryRequestModel ,
                        completion: @escaping (Result<DealStatusChangeHistoryResponseModel, Error>) -> Void) {

        let request = Request(endPoint: dealStatusChangeHistoryEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)

        service.execute(request, responseType: DealStatusChangeHistoryResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    // MARK: - Список заметок потенциала
    public func getCommentsList(dataModel: ListRequestModel,
                        completion: @escaping (Result<DealCommentsListResponseModel, Error>) -> Void) {

        let request = Request(endPoint: dealCommentsListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)

        service.execute(request, responseType: DealCommentsListResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Добавление заметки
    public func addComment(dataModel: AddDealCommentRequestModel,
                        completion: @escaping (Result<DealCommentResponseModel, Error>) -> Void) {

        let request = Request(endPoint: addDealCommentEndPoint, method: .put, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)

        service.execute(request, responseType: DealCommentResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Редактирование заметки
    public func editComment(dataModel: EditDealCommentRequestModel,
                        completion: @escaping (Result<DealCommentResponseModel, Error>) -> Void) {

        let request = Request(endPoint: editDealCommentEndPoint, method: .patch, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)

        service.execute(request, responseType: DealCommentResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Удаление заметки
    public func deleteComment(dataModel: DeleteDealCommentRequestModel,
                        completion: @escaping (Result<Void, Error>) -> Void) {

        let request = Request(endPoint: deleteDealCommentEndPoint, method: .delete, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)

        service.execute(request, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
