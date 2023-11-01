//
//  BarBackgroundSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class BarBackgroundSurface: CALayer {

    // MARK: - Private Properties

    private var lines = [CALayer]()

    private var lineWidth: CGFloat = 1
    private var lineColor: UIColor = Colors.red01
    private var solidLineColor: UIColor = Colors.red01

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

extension BarBackgroundSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartVerticalAxisDataProviderProtocol else { return }
        let values = dataProvider.normalizedVerticalValues

        lines.forEach { $0.removeFromSuperlayer() }
        values.forEach { normY, _ in
            let itemY = normY * bounds.height

            let layer = CAShapeLayer()
            layer.contentsScale = UIScreen.main.scale
            layer.frame = CGRect(x: 0, y: itemY, width: bounds.width, height: lineWidth)
            layer.lineWidth = lineWidth
            layer.backgroundColor = Colors.clear.cgColor

            if normY == 1 {
                layer.strokeColor = solidLineColor.cgColor
            } else {
                layer.lineDashPattern = [4, 4]
                layer.strokeColor = lineColor.cgColor
            }

            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: layer.bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: layer.bounds.midY))
            layer.path = path

            addSublayer(layer)
            lines.append(layer)
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? BarBackgroundStyleProtocol else { return }

        lineWidth = style.barBackgroundLineWidth
        lineColor = style.barBackgroundLineColor
        solidLineColor = style.barBackgroundBottomLineColor
    }
}

