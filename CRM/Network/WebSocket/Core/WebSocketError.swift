//
//  WebSocketError.swift
//  CRM
//
//  Created by Aleksei Chudin on 03.09.2023.
//

import Foundation

/// Ошибки, связанные только с вебсокет соединением
public enum WebSocketError: LocalizedError {
    case disconnected
    case serializationError

    public var errorDescription: String? {
        switch self {
        case .serializationError:
            return "Не удалось сформировать сообщение"
        case .disconnected:
            return "Соединение прервано"
        }
    }
}
