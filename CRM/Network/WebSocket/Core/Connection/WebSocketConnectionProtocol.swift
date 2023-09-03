//
//  WebSocketConnectionProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

/// Вебсокет соединение. Отвечает непосредственно за реализацию
protocol WebSocketConnectionProtocol {

    init(_ configuration: WebSocketConfigurationProtocol)

    func open()
    func send(data: Data, completion: @escaping () -> Void)
    func close()
    func sendPing()

    var isConnected: Bool { get }
    var connectionOpenClosure: (() -> Void)? { get set }
    var dataClosure: ((Data) -> Void)? { get set }
    var connectionCloseClosure: ((Error?) -> Void)? { get set }
}
