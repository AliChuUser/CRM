//
//  ChartView+ChartType.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import Foundation

extension ChartView {

    /// Вид графика (линейный, столбчатый итд)
    public enum ChartType {

        private var horizontalAxisHeight: CGFloat { 16 }
        private var verticalAxisWidth: CGFloat { 30 }
        private var legendHeight: CGFloat { 36 }
        private var legendSpacing: CGFloat { 8 }

        case line
        case bar
        case pie
        case table

        func makeStyle() -> ChartStyleProtocol {
            switch self {
            case .line:
                return LineChartStyle.normal
            case .bar:
                return BarChartStyle.normal
            case .pie:
                return PieChartStyle.normal
            case .table:
                return TableChartStyle.normal
            }
        }

        func makeDataProvider(withModel model: ChartModel) -> ChartDataProviderProtocol {
            var provider: ChartDataProviderProtocol
            switch self {
            case .line:
                provider = LineChartDataProvider(model: model)
            case .bar:
                provider = BarChartDataProvider(model: model)
            case .pie:
                provider = PieChartDataProvider(model: model)
            case .table:
                provider = TableChartDataProvider(model: model)
            }
            return provider
        }

        func makeSurfaces() -> [ChartSurfaceProtocol] {
            switch self {
            case .line:
                return [
                    LineBackgroundSurface(),
                    LineChartSurface(),
                    HorizontalAxisSurface(),
                    VerticalAxisSurface(),
                ]
            case .bar:
                return [
                    BarBackgroundSurface(),
                    BarChartSurface(),
                    VerticalAxisSurface(),
                ]
            case .pie:
                return [
                    PieChartSurface(),
                    PieChartLegendSurface(),
                ]
            case .table:
                return [
                    TableChartSurface(),
                    HorizontalAxisSurface(),
                    VerticalAxisSurface(),
                    TableLegendSurface(),
                ]
            }
        }

        func layoutSurfaces(surfaces: [ChartSurfaceProtocol], in view: UIView, with style: ChartStyleProtocol) {
            let bounds = view.bounds

            let leftAxisCount = surfaces.filter { $0.surfaceType == .verticalAxis }.count
            let bottomAxisCount = surfaces.filter { $0.surfaceType == .horizontalAxis }.count
            let legendCount = surfaces.filter { $0.surfaceType == .legend }.count


            let totalLegendHeight = CGFloat(legendCount) * (legendHeight + legendSpacing)
            let totalBottomAxisHeight = CGFloat(bottomAxisCount) * horizontalAxisHeight

            let totalLeftAxisWidth = CGFloat(leftAxisCount) * verticalAxisWidth

            let totalVerticalInsets = style.chartInsets.top + style.chartInsets.bottom
            let totalHorizontalInsets = style.chartInsets.left + style.chartInsets.right


            CATransaction.begin()
            CATransaction.setDisableActions(true)

            // Обновляем вертикальные оси
            var surfaceIndex = 0
            surfaces.forEach {
                guard $0.surfaceType == .verticalAxis else { return }
                $0.frame = CGRect(x: CGFloat(surfaceIndex) * verticalAxisWidth,
                                  y: style.chartInsets.top,
                                  width: verticalAxisWidth,
                                  height: bounds.height - totalVerticalInsets - totalBottomAxisHeight - totalLegendHeight)
                surfaceIndex += 1
            }

            // Обновляем легенду
            surfaceIndex = 0
            surfaces.forEach {
                guard $0.surfaceType == .legend else { return }
                $0.frame = CGRect(x: totalLeftAxisWidth + style.chartInsets.left,
                                  y: bounds.height - legendHeight - (legendHeight + legendSpacing) * CGFloat(surfaceIndex),
                                  width: bounds.width - totalLeftAxisWidth - totalHorizontalInsets,
                                  height: legendHeight)
                surfaceIndex += 1
            }

            // Обновляем нижние оси
            surfaceIndex = 0
            surfaces.forEach {
                guard $0.surfaceType == .horizontalAxis else { return }
                $0.frame = CGRect(x: totalLeftAxisWidth + style.chartInsets.left,
                                  y: bounds.height - horizontalAxisHeight * CGFloat(surfaceIndex + 1) - totalLegendHeight,
                                  width: bounds.width - totalLeftAxisWidth - totalHorizontalInsets,
                                  height: horizontalAxisHeight)
                surfaceIndex += 1
            }


            // Обновляем графики
            surfaceIndex = 0
            surfaces.forEach {
                guard $0.surfaceType == .chart else { return }
                $0.frame = CGRect(x: totalLeftAxisWidth + style.chartInsets.left,
                                  y: style.chartInsets.top,
                                  width: bounds.width - totalLeftAxisWidth - totalHorizontalInsets,
                                  height: bounds.height - totalBottomAxisHeight - totalLegendHeight - totalVerticalInsets)
                surfaceIndex += 1
            }

            CATransaction.commit()
        }
    }
}
