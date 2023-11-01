//
//  TableChartDataProvider.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class TableChartDataProvider: ChartDataProviderProtocol, ChartTableDataProviderProtocol, ChartHorizontalAxisDataProviderProtocol, ChartVerticalAxisDataProviderProtocol, ChartTableLegendDataProviderProtocol {

    private var valueGroupCount = 0

    var model: ChartModel?

    public private (set) var normalizedCellValues: [[CGFloat]] = []
    public private (set) var normalizedHorizontalValues: [(CGFloat, String)] = []
    public private (set) var normalizedVerticalValues: [(CGFloat, String)] = []
    public private (set) var normalizedLegendCellData: [String] = []

    required init(model: ChartModel) {
        self.model = model
    }

    func recalc() {
        reset()
        guard let model = model, let data = model.doubleAxisData else { return }

        var maxValue = data.values.max(by: { (a, b) -> Bool in
            a.max() ?? 0 > b.max() ?? 0
        })?.max() ?? 0
        maxValue = maxValue.nextRoundNumber ?? maxValue


        let sizePerHorizontalValue = CGFloat(1) / CGFloat(data.horizontalAxisTitles.count)
        normalizedHorizontalValues = data.horizontalAxisTitles.indices.map { i in
            let normX = CGFloat(i) / CGFloat(data.horizontalAxisTitles.count) + sizePerHorizontalValue / 2
            return (normX, data.horizontalAxisTitles[i])
        }

        let sizePerVerticalValue = CGFloat(1) / CGFloat(data.verticalAxisTitles.count)
        normalizedVerticalValues = data.verticalAxisTitles.indices.map { i in
            let normX = CGFloat(i) / CGFloat(data.verticalAxisTitles.count) + sizePerVerticalValue / 2
            return (normX, data.verticalAxisTitles[i])
        }

        // Разделение значений на группы и округление всех значений внутри группы
        let groupValues = Array(0..<(valueGroupCount + 1)).map { CGFloat($0 + 1) / CGFloat(valueGroupCount + 1) }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        normalizedLegendCellData = groupValues.map { formatter.string(from: NSNumber(value: Int($0 * CGFloat(maxValue)))) ?? "\($0)" }

        // Преобразование двумерного массива значений в нормализованные значения для отрисовки
        data.values.indices.forEach { i in
            let column = data.values[i]
            let columnNorm: [CGFloat] = column.indices.map { j in
                let valueNorm = CGFloat(column[j]) / CGFloat(maxValue)
                let clampedValue = groupValues.first(where: { $0 > valueNorm })
                return clampedValue ?? valueNorm
            }
            normalizedCellValues.append(columnNorm)
        }
    }

    func reset() {
        normalizedVerticalValues = []
        normalizedHorizontalValues = []
        normalizedCellValues = []
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? TableStyleProtocol else { return }
        valueGroupCount = style.tableValueGroupCount
    }
}
