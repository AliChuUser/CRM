//
//  LineChartDataProvider.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class LineChartDataProvider: ChartDataProviderProtocol, ChartPointsProviderProtocol, ChartHorizontalAxisDataProviderProtocol, ChartVerticalAxisDataProviderProtocol {

    private var clampToLowest: Bool = true

    var model: ChartModel?

    public var values: [Int] = []

    public private (set) var normalizedVisiblePoints: [(CGPoint, UIColor)] = []
    public private (set) var normalizedHorizontalValues: [(CGFloat, String)] = []
    public private (set) var normalizedVerticalValues: [(CGFloat, String)] = []

    private var leftAxisTitleCount = 2
    private var dateFormatter: DateFormatter?

    required init(model: ChartModel) {
        self.model = model
    }

    func hitTest(normalizedPoint point: CGPoint) -> (Int, String)? {
        var closestIndex: Int?
        var closestValue: CGFloat = .greatestFiniteMagnitude
        normalizedHorizontalValues.indices.forEach {
            let dist = abs(normalizedHorizontalValues[$0].0 - point.x)
            if dist < closestValue {
                closestValue = dist
                closestIndex = $0
            }
        }
        guard let index = closestIndex, index >= 0, index < values.count else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let title: String = formatter.string(from: NSNumber(value: values[index])) ?? "\(values[index])"
        return (index, title)
    }

    func recalc() {
        guard let model = model else { return }

        // Расчет видимого диапазона
        var minValue = clampToLowest ? 0 : model.singleAxisData.values.map { $0 }.reduce(Int.max, { min($0, $1) })
        var maxValue = model.singleAxisData.values.map{ $0 }.reduce(Int.min, { max($0, $1) })

        let visibleValuesRange = pickBestVisibleRange(initialRange: minValue ... maxValue)
        minValue = visibleValuesRange.lowerBound
        maxValue = visibleValuesRange.upperBound

        // Ширина на одну точку
        let widthPerValue = CGFloat(1) / CGFloat(model.singleAxisData.values.count)

        // Сохраняем сортированный массив значений для обработки нажатий
        values = model.singleAxisData.values

        // Расчет нормализованных CGPoint-ов для отрисовки
        normalizedVisiblePoints = model.singleAxisData.values.indices.map {
            let color = model.singleAxisData.colors[$0]
            var value = CGFloat(model.singleAxisData.values[$0])
            value -= CGFloat(minValue)
            value /= CGFloat(maxValue - minValue)
            let x = CGFloat($0) / CGFloat(model.singleAxisData.values.count) + widthPerValue / 2
            return (CGPoint(x: x, y: value), color)
        }

        // Нижние подписи и их позиции
        normalizedHorizontalValues = model.singleAxisData.titles.indices.compactMap { i in
            guard i >= 0, i < normalizedVisiblePoints.count else { return nil }
            let point = normalizedVisiblePoints[i]
            let title = model.singleAxisData.titles[i]
            return (point.0.x, title)
        }

        // Левые подписи и их позиции
        let count = min(leftAxisTitleCount, maxValue - minValue + 1)
        normalizedVerticalValues = []
        for i in 0 ..< count {
            let rate = count > 1 ? CGFloat(i) / CGFloat(count - 1) : CGFloat(i)
            let number = CGFloat(minValue) + CGFloat(maxValue - minValue) * (1 - rate)
            let roundedNumber = String(number: Int(number))
            normalizedVerticalValues.append((rate, roundedNumber))
        }
    }

    func reset() {
        normalizedVisiblePoints = []
        normalizedVerticalValues = []
        normalizedHorizontalValues = []
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        if let verticalStyle = style as? VerticalAxisStyleProtocol {
            leftAxisTitleCount = verticalStyle.verticalTitlesCount
        }
        if let lineStyle = style as? LineStyleProtocol {
            clampToLowest = lineStyle.clampToLowestValue
        }
    }

    /// Корректирует диапазон initialRange до того момента, когда отметки на левой шкале не будут ровными числами.
    /// - Parameter initialRange: стартовое значение
    private func pickBestVisibleRange(initialRange: ClosedRange<Int>) -> ClosedRange<Int> {

        let scalingTicks = Array(0 ..< leftAxisTitleCount).map { CGFloat($0) / CGFloat(leftAxisTitleCount - 1) }

        var allPointsRoundedCorrectly = false

        let newMin = initialRange.lowerBound
        var newMax = initialRange.upperBound

        var maxIterations = 1000

        while !allPointsRoundedCorrectly {
            allPointsRoundedCorrectly = true
            maxIterations -= 1
            guard maxIterations > 0 else { break }

            scalingTicks.forEach { tickNorm in
                let tick = newMin + Int(tickNorm * CGFloat(newMax - newMin))

                if !tick.isRound {
                    allPointsRoundedCorrectly = false
                    newMax = (newMax + 1).nextRoundNumber ?? (newMax + 1)
                    return
                }
            }
        }
        return newMin ... newMax
    }
}

