//
//  Expiration.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.02.2024.
//

import Foundation

enum Expiration {

    case never

    case seconds(TimeInterval)

    case days(TimeInterval)

    case date(Date)

    var date: Date {
        switch self {
        case .never:
            // хранение данных на диске в течение 365 дней
            return Date().addingTimeInterval(60 * 60 * 24 * 365)
        case .seconds(let seconds):
            return Date().addingTimeInterval(seconds)
        case .days(let days):
            return Date().addingTimeInterval(60 * 60 * 24 * days)
        case .date(let date):
            return date
        }
    }

}
