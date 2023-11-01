//
//  ChartModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

public class ChartModel {

    typealias ChartSingleAxisData = (titles: [String], colors: [UIColor], values: [Int])
    typealias ChartDoubleAxisData = (horizontalAxisTitles: [String], verticalAxisTitles: [String], values: [[Int]])

    private static let locale = Locale(identifier: "Ru-ru")

    /// Основная группировка. Отвечает за группировку дат (по горизонтали на линейном графике)
    public var groupType: ChartGroupType

    /// Дополнительная группировка (нужна для графиков типа табличного)
    public var auxiliaryGroupType: ChartGroupType?

    var singleAxisData: ChartSingleAxisData
    var doubleAxisData: ChartDoubleAxisData?

    public init(data: [ChartStringValue], groupType: ChartGroupType) {
        self.groupType = groupType
        self.singleAxisData = (titles: data.map { $0.title },
                               colors: data.map { $0.color },
                               values: data.map { $0.value })
    }

    public init(data: [ChartDateValue], groupType: ChartGroupType, auxiliaryGroupType: ChartGroupType? = nil) {
        self.groupType = groupType
        self.auxiliaryGroupType = auxiliaryGroupType

        // TODO: правильная сортировка дат
        // Создание данных для двумерных графиков (табличный)
        if let auxiliaryGroupType = auxiliaryGroupType {
            var result = [String: [ChartDateValue]]()
            data.forEach { point in
//                let horizontalDate = ChartModel.trim(date: point.date, for: groupType)
                let horizontalString = point.title

                if let _ = result[horizontalString] {
                    var array = result[horizontalString]
                    array!.append(point)
                    result[horizontalString] = array
                } else {
                    result[horizontalString] = [point]
                }
            }
            var resultTrimmed = [String: [ChartStringValue]]()
            result.forEach { (key, value) in
                let trimmedValue = value.map { dateValue -> ChartStringValue in
                    let verticalDate = ChartModel.trim(date: dateValue.date, for: auxiliaryGroupType)
                    let dValue = ChartDateValue(date: verticalDate, value: dateValue.value, color: .orange, dateGroupType: auxiliaryGroupType)

                    return ChartStringValue(title: dValue.title, value: dateValue.value, color: dateValue.color)
                }
                resultTrimmed[key] = trimmedValue
            }

            var horizontalAxisTitles = [String]()
            var verticalAxisTitles = [String]()
            var values = [[Int]]()

            resultTrimmed.forEach { key, value in
                horizontalAxisTitles.append(key)
                if verticalAxisTitles.isEmpty {
                    verticalAxisTitles = value.map { $0.title }
                }
                values.append(value.map { $0.value })
            }
            doubleAxisData = (horizontalAxisTitles, verticalAxisTitles, values)
        }

        // Создание данных для одномерных графиков (линейный, столбчатый ...)

        // Приведение всех значений к одному формату (GroupType) и их группировка
        var result = [ChartDateValue]()
        data.forEach { point in
            let pointDate = ChartModel.trim(date: point.date, for: groupType)
            if let first = result.first(where: {
                ChartModel.locale.calendar.compare($0.date, to: pointDate, toGranularity: groupType.calendarComponent) == .orderedSame
            }) {
                first.value += point.value
            } else {
                let clearedValue = ChartDateValue(date: pointDate, value: point.value, color: .green, dateGroupType: groupType)
                result.append(clearedValue)
            }
        }
        // Конвертирование дат в строки
        self.singleAxisData = (titles: result.map { $0.title },
                               colors: result.map { $0.color },
                               values: result.map { $0.value })
    }

    /// Возвращает дату с очищенными полями согласно переданному groupType.
    /// Пример 1: Если вызвать эту функцию для "04.08.2000" с groupType == .byMonth, то вернется 01.08.2000
    /// Пример 2: Если вызвать эту функцию для "18.08.2000" с groupType == .byMonth, то вернется 01.08.2000
    /// Пример 3: Если вызвать эту функцию для "03.05.2000 12:34" с groupType == .byDay, то вернется 03.05.2000
    /// - Parameters:
    ///   - date: дата, которую необходимо преобразовать
    ///   - groupType: отвечает за то, какие поля будет осталены у даты
    private static func trim(date: Date, for groupType: ChartGroupType) -> Date {
        switch groupType {
        case .byHour:
            return date
        case .byDay:
            return locale.calendar.date(bySettingHour: 0,
                                                       minute: 0,
                                                       second: 0,
                                                       of: date) ?? date
        case .byWeekday:
            let weekday = locale.calendar.component(.weekday, from: date)
            return DateComponents(calendar: locale.calendar, weekday: weekday, weekdayOrdinal: 1).date ?? date
        case .byMonth:
            guard let trimmedDate = locale.calendar.date(bySettingHour: 0,
                                                                        minute: 0,
                                                                        second: 0,
                                                                        of: date)
            else {
                return date
            }

            var component = locale.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: trimmedDate)
            component.day = 1
            return locale.calendar.date(from: component) ?? trimmedDate
        }
    }
}
