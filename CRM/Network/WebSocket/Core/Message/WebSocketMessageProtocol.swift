//
//  WebSocketMessageProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

/// Модель сообщения, отправляемого и получаемого при вебсокет взаимодействии.
/// Сообщение должно уметь конвертироваться в Data и обратно
public protocol WebSocketMessageProtocol {

    var binaryData: Data? { get }

    init?(binaryData: Data)
}
