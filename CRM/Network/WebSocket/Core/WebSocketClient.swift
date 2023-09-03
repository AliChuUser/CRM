//
//  WebSocketClient.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

/// Клиент для работы с вебсокетами. MessageType - тип, в который будут сериализоваться сообщения
public class WebSocketClient<MessageType: WebSocketMessageProtocol> {

    /// Настройки клиента и соединения
    private var configuration: WebSocketConfigurationProtocol
    /// Соединение. Отвечает непосредственно за реализацию
    private var connection: WebSocketConnectionProtocol

    /// Замыкание успешной обработки входящих сообщений
    public var onMessage: ((MessageType) -> Void)?
    /// Замыкание ошибок
    public var onError: ((WebSocketError) -> Void)?
    public var onConnection: (()-> Void)?
    public var isConnected: Bool { connection.isConnected }

    public init(configuration: WebSocketConfigurationProtocol) {
        self.configuration = configuration
        self.connection = WebSocketConnection(configuration)

        self.connection.dataClosure = { [weak self] data in
            self?.webSocketDidReceiveData(data)
        }
        
        self.connection.connectionCloseClosure = { [weak self] error in
            self?.webSocketDidClose(error: error)
        }
        
        self.connection.connectionOpenClosure = { [weak self] in
            self?.onConnection?()
        }
    }

    /// Отправляет объект message
    ///
    /// - Parameters:
    ///   - message: объект, который будет отправлен
    ///   - completion: замыкание результата выполнения
    public func send(message: MessageType, completion: @escaping (Result<Void, WebSocketError>) -> Void) {
        guard let data = message.binaryData else {
            completion(.failure(.serializationError))
            return
        }
        connection.send(data: data) {
            completion(.success(()))
        }
    }
    
    public func openConnection() {
        print("Connection opened")
        connection.open()
    }
    
    public func closeConnection() {
        print("Connection closed")
        connection.close()
    }
    
    public func send(data: MessageType) {
        guard let data = data.binaryData else { return }
        connection.send(data: data) {}
    }
    
    /// Отправка пинг-запроса на сервер для поддержания соединения
    public func sendPing() {
        connection.sendPing()
    }

    // MARK: - Private

    private func webSocketDidReceiveData(_ data: Data) {
        guard let message = MessageType(binaryData: data) else {
            onError?(.serializationError)
            return
        }
        print("RECEIVED:\n\(message)\n")
        onMessage?(message)
    }
    
    private func webSocketDidClose(error: Error?) {
        onError?(.disconnected)
    }
    
    deinit {
        connection.close()
    }
}
