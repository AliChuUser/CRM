//
//  WebSocketConnection.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation
import Starscream

/// Реализация вебсокет соединения, построенная на базе библиотеки Starscream
class WebSocketConnection: WebSocketConnectionProtocol {

    private var socket: WebSocket
    private var configuration: WebSocketConfigurationProtocol

    var isConnected: Bool {
        socket.isConnected
    }
    var connectionOpenClosure: (() -> Void)?
    var dataClosure: ((Data) -> Void)?
    var connectionCloseClosure: ((Error?) -> Void)?

    required init(_ configuration: WebSocketConfigurationProtocol) {
        self.configuration = configuration
        socket = WebSocket(url: configuration.url, protocols: [])
        socket.disableSSLCertValidation = !configuration.sslValidationEnabled

        socket.onConnect = { [weak self] in
            guard let self = self else { return }
            self.webSocketDidConnect()
        }
        socket.onDisconnect = { [weak self] error in
            guard let self = self else { return }
            self.webSocketDidDisconnect(error: error)
        }
        socket.onData = { [weak self] data in
            guard let self = self else { return }
            self.webSocketDidReceiveData(data)
        }
    }

    // MARK: - Connection control

    func open() {
        socket.connect()
    }

    func send(data: Data, completion: @escaping () -> Void) {
        socket.write(data: data, completion: {
            completion()
        })
    }

    func close() {
        socket.disconnect(forceTimeout: configuration.connectionCloseTimeout, closeCode: CloseCode.normal.rawValue)
    }
    
    func sendPing() {
        socket.write(ping: Data())
    }

    // MARK: - Private

    private func webSocketDidConnect() {
        connectionOpenClosure?()
    }

    private func webSocketDidReceiveData(_ data: Data) {
        dataClosure?(data)
    }

    private func webSocketDidDisconnect(error: Error?) {
        connectionCloseClosure?(error)
    }
}
