//
//  Date+Extensions.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation

public extension Date {
    func formatter(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ru")
        let strDate = formatter.string(from: self)
        guard let date = formatter.date(from: strDate) else { return nil }
        return date
    }

    func relativeDateSwitcher(format: String) -> String? {
        let calendar = Calendar.current

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: self)

        var dateString: String

        if calendar.isDateInYesterday(self) {
            dateString = "Вчера"
        } else if calendar.isDateInToday(self) {
            dateString = "Сегодня"
        } else if calendar.isDateInTomorrow(self) {
            dateString = "Завтра"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru")
            dateFormatter.dateFormat = "d MMMM yyyy"
            dateString = dateFormatter.string(from: self)
        }
        return "\(dateString), \(timeString)"
    }
}
