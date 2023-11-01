//
//  PieChartDataProvider.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class PieChartDataProvider: ChartDataProviderProtocol, ChartPercentageDataProviderProtocol, ChartSummaryDataProviderProtocol {

    var model: ChartModel?

    public private (set) var summaryTitle: String = ""
    public private (set) var summarySubtitle: String = ""
    public private (set) var normalizedValues: [String: (CGFloat, UIColor)] = [:]

    required init(model: ChartModel) {
        self.model = model
    }

    func recalc() {
        guard let model = model else { return }

        let totalCount = model.singleAxisData.values.reduce(into: 0) { (result, next) in
            result += next
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        if let formattedNumber = formatter.string(from: NSNumber(value: totalCount)) {
            summaryTitle = formattedNumber
        }
        summarySubtitle = "Всего сделок".lowercased()

        normalizedValues = [:]
        model.singleAxisData.titles.indices.forEach {
            let title = model.singleAxisData.titles[$0]
            let value = model.singleAxisData.values[$0]
            let color = model.singleAxisData.colors[$0]
            normalizedValues[title] = (CGFloat(value) / CGFloat(totalCount), color)
        }
    }

    func reset() {
        summaryTitle = ""
        summarySubtitle = ""
        normalizedValues = [:]
    }

    func applyStyle(_ style: ChartStyleProtocol) { }
}


