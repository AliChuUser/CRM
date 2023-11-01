//
//  PieChartSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class PieChartSurface: CALayer {

    // MARK: - Private Properties

    private var shadowShape: CAShapeLayer?
    private var shapes = [CALayer]()
//    private var colors: [UIColor] = [Colors.green01]
    private var lineWidth: CGFloat = 1

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
        masksToBounds = false
    }
}

// MARK: - ChartSurfaceProtocol

extension PieChartSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartPercentageDataProviderProtocol else { return }
        let points = dataProvider.normalizedValues

        let rect = bounds
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - lineWidth / 2

        shapes.forEach { $0.removeFromSuperlayer() }

        var previousAngle: CGFloat = 0

        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: 0,
                                endAngle: 2 * .pi,
                                clockwise: true)
        path.close()

        self.shadowShape?.removeFromSuperlayer()
        self.shadowShape = nil

        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = rect
        shadowLayer.backgroundColor = Colors.clear.cgColor
        shadowLayer.fillColor = Colors.clear.cgColor
        shadowLayer.strokeColor = Colors.white.cgColor
        shadowLayer.lineWidth = lineWidth
        shadowLayer.path = path.cgPath
        shadowLayer.masksToBounds = false
        shadowLayer.shadowColor = Colors.Charts.pieShadow.cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 12
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)

        addSublayer(shadowLayer)
        self.shadowShape = shadowLayer

        points.sorted(by: { $0.1.0 > $1.1.0 }).forEach { (name, value) in
            let normValue = value.0
            let color = value.1
            let newAngle = previousAngle + normValue

            let layer = CAShapeLayer()
            layer.opacity = 1
            layer.frame = rect
            layer.backgroundColor = Colors.clear.cgColor
            layer.fillColor = Colors.clear.cgColor
            layer.strokeColor = color.cgColor
            layer.lineWidth = lineWidth
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.strokeStart = previousAngle
            layer.strokeEnd = newAngle
            layer.path = path.cgPath
            layer.masksToBounds = true

            addSublayer(layer)
            shapes.append(layer)

            previousAngle = newAngle
//            colorIndex += 1
//            if colorIndex >= colors.count {
//                colorIndex = 0
//            }
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? PieStyleProtocol else { return }
        lineWidth = style.lineWidth
    }
}
