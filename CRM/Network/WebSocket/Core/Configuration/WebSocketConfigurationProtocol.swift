//
//  WebSocketConfigurationProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

/// Конфигурация вебсокет соединения
public protocol WebSocketConfigurationProtocol {

    /// Точка входа. Полный путь
    var url: URL { get }
    /// Включена ли валидация SSL
    var sslValidationEnabled: Bool { get }
    /// Время с момента последнего ping/pong сообщения, по истечению которого соединение будет сброшено
    var connectionCloseTimeout: TimeInterval { get }
}
