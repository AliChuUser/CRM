//
//  TasksOperation.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

public class TasksOperation {
    
    let tasksListEndPoint: String = "v1/tasks/list"
    let changeTaskStatusEndPoint: String = "v1/tasks/status/info"
    let taskInfoEndPoint: String = "v1/tasks/info"
    let taskFullEndPoint: String = "v1/tasks/show"
    let taskCommentListEndPoint: String = "v1/tasks/comments/list"
    let createTaskCommentEndPoint: String = "v1/tasks/comments/create"
    let editTaskCommentEndPoint: String = "v1/tasks/comments/update"
//    let tasksDictionaryListEndPoint: String = "/v1/dictionary/list"
//    let taskAddConnectionEndPoint: String = "v1/tasks/connection"
//    let taskCreateEndPoint: String = "v1/tasks/create"
    
    private var service: ServiceProtocol
    
    public init(in service: ServiceProtocol) {
        self.service = service
    }

    // MARK: - Просмотр списка задач
    public func getList(dataModel: ListRequestModel,
                        completion: @escaping (Result<TasksListResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: tasksListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: TasksListResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Изменение статуса задачи
    public func changeTaskStatus(dataModel: TaskRequestModel,
                        completion: @escaping (Result<ChangeTaskStatusResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: changeTaskStatusEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: ChangeTaskStatusResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Карточка задачи (шапка)
    public func getTaskInfo(dataModel: TaskRequestModel,
                        completion: @escaping (Result<TaskResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: taskInfoEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: TaskResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Карточка задачи (полная информация)
    public func getTaskFull(dataModel: TaskRequestModel,
                        completion: @escaping (Result<TaskResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: taskFullEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: TaskResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Список заметок задачи
    public func getCommentList(dataModel: TaskCommentListRequestModel,
                        completion: @escaping (Result<TaskCommentListResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: taskCommentListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: TaskCommentListResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Добавление заметки к задаче
    public func createComment(dataModel: CreateTaskCommentRequestModel,
                        completion: @escaping (Result<TaskCommentResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: createTaskCommentEndPoint, method: .put, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: TaskCommentResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // MARK: - Редактирование заметки задачи
    public func editComment(dataModel: EditTaskCommentRequestModel,
                        completion: @escaping (Result<TaskCommentResponseModel, Error>) -> Void) {
        
        let request = Request(endPoint: editTaskCommentEndPoint, method: .patch, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
        
        service.execute(request, responseType: TaskCommentResponseModel.self, completion: { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
//    // MARK: - Запрос справочников
//    public func getDictionaryList(dataModel: TaskDictionaryListRequestModel,
//                        completion: @escaping (Result<TaskDictionaryListResponseModel, Error>) -> Void) {
//
//        let request = Request(endPoint: tasksDictionaryListEndPoint, method: .post, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
//
//        service.execute(request, responseType: TaskDictionaryListResponseModel.self, completion: { result in
//            switch result {
//            case .success(let model):
//                completion(.success(model))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//    }
//
//    // MARK: - Добавить связь к задаче
//    public func addConnection(dataModel: AddTaskConnectionRequestModel,
//                        completion: @escaping (Result<AddTaskConnectionResponseModel, Error>) -> Void) {
//
//        let request = Request(endPoint: taskAddConnectionEndPoint, method: .put, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
//
//        service.execute(request, responseType: AddTaskConnectionResponseModel.self, completion: { result in
//            switch result {
//            case .success(let model):
//                completion(.success(model))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//    }
//
//    // MARK: - Создать задачу
//    public func createTask(dataModel: CreateTaskRequestModel,
//                        completion: @escaping (Result<CreateTaskResponseModel, Error>) -> Void) {
//
//        let request = Request(endPoint: taskCreateEndPoint, method: .put, header: Header(configurationHeaders: "application/json; charset=utf-8", forHTTPHeaderField: "Content-Type"), dataModel: dataModel)
//
//        service.execute(request, responseType: CreateTaskResponseModel.self, completion: { result in
//            switch result {
//            case .success(let model):
//                completion(.success(model))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
//    }
    
}
