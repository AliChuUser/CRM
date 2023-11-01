//
//  ChartGroupType.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import Foundation

/// Вид группировки значений
public enum ChartGroupType {
    case byHour
    case byDay
    case byWeekday
    case byMonth

    var dateFormatString: String {
        switch self {
        case .byWeekday:
            return "E"
        case .byHour:
            return "HH"
        case .byDay:
            return "dd.MM"
        case .byMonth:
            return "MMM"
        }
    }

    var calendarComponent: Calendar.Component {
        switch self {
        case .byHour:
            return .hour
        case .byDay:
            return .day
        case .byWeekday:
            return .weekday
        case .byMonth:
            return .month
        }
    }

    var underlyingGroupType: ChartGroupType? {
        switch self {
        case .byHour:
            return nil
        case .byDay:
            return .byHour
        case .byWeekday:
            return .byDay
        case .byMonth:
            return .byMonth
        }
    }

    var overlyingGroupType: ChartGroupType? {
        switch self {
        case .byHour:
            return .byDay
        case .byDay:
            return .byWeekday
        case .byWeekday:
            return .byMonth
        case .byMonth:
            return nil
        }
    }
}
