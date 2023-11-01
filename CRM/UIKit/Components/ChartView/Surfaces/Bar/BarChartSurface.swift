//
//  BarChartSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class BarChartSurface: CALayer {

    // MARK: - Private Properties

    private var shapes = [CALayer]()

    private var barWidth: CGFloat?
    private var barCornerRadius: CGFloat = 8
    private var barInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)

    // MARK: - Lifecycle

    override init() {
        super.init()
        initialSetup()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }

    // MARK: - Private methods

    private func initialSetup() {
        backgroundColor = Colors.clear.cgColor
    }
}

// MARK: - ChartSurfaceProtocol

extension BarChartSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartPointsProviderProtocol else { return }
        let points = dataProvider.normalizedVisiblePoints

        let rect = bounds
        let barWidth = self.barWidth ?? rect.width / CGFloat(points.count)

        let convertedPoints: [CGPoint] = points.indices.map { index in
            let x = points[index].0.x * rect.width + rect.minX
            let y = (1 - points[index].0.y) * rect.height + rect.minY
            return CGPoint(x: x, y: y)
        }

        shapes.forEach { $0.removeFromSuperlayer() }

        convertedPoints.indices.forEach { index in
            let x = points[index].0.x * rect.width + rect.minX - barWidth / 2
            let height = points[index].0.y * rect.height + rect.minY

            let layer = CAShapeLayer()
            layer.opacity = 1
            layer.frame = CGRect(x: x, y: rect.height - height, width: barWidth, height: height).inset(by: barInsets)
            layer.backgroundColor = Colors.clear.cgColor
            layer.fillColor = points[index].1.cgColor
            layer.masksToBounds = true

            let path = UIBezierPath(roundedRect: layer.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: barCornerRadius, height: barCornerRadius))
            layer.path = path.cgPath

            addSublayer(layer)
            shapes.append(layer)
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? BarStyleProtocol else { return }

        barInsets = style.barInsets
        barCornerRadius = style.barCornerRadius
        barWidth = style.barWidth
    }
}
