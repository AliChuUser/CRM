//
//  ChartDateValue.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

public class ChartDateValue {

    private static let locale = Locale(identifier: "Ru-ru")

    public var title: String
    public var value: Int
    public var date: Date
    public var color: UIColor

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        return formatter
    }()

    public init(date: Date, value: Int, color: UIColor, dateGroupType: ChartGroupType = .byWeekday) {
        self.value = value
        self.date = date
        self.color = color
        self.title = ChartDateValue.format(date: self.date, groupType: dateGroupType)
    }

    private static func format(date: Date, groupType: ChartGroupType) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = groupType.dateFormatString
        return formatter.string(from: date)
    }
}
