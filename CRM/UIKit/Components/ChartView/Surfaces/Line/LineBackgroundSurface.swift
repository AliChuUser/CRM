//
//  LineBackgroundSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class LineBackgroundSurface: CALayer, ChartSurfaceSelectableProtocol {

    // MARK: - Public Properties

    public var selectionIndex: Int?
    public var selectionTitle: String?

    // MARK: - Private Properties

    private var rects = [CALayer]()

    private var barGradientColorsNormal: [UIColor] = []
    private var barGradientColorsSelected: [UIColor] = []
    private var barCornerRadius: CGFloat = 8
    private var barInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)

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

extension LineBackgroundSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartPointsProviderProtocol else { return }
        let points = dataProvider.normalizedVisiblePoints

        let rect = bounds
        let barWidth = rect.width / CGFloat(points.count)

        rects.forEach { $0.removeFromSuperlayer() }

        points.indices.forEach { index in
            let colors = (index == selectionIndex ? barGradientColorsSelected : barGradientColorsNormal)
            let x = points[index].0.x * rect.width + rect.minX - barWidth / 2

            let layer = CAGradientLayer()
            layer.opacity = 1
            layer.frame = CGRect(x: x, y: 0, width: barWidth, height: rect.height).inset(by: barInsets)
            layer.colors = colors.map { $0.cgColor }
            layer.startPoint = .zero
            layer.endPoint = CGPoint(x: 0, y: 1)
            layer.cornerRadius = barCornerRadius
            layer.masksToBounds = true

            addSublayer(layer)
            rects.append(layer)
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? LineBackgroundStyleProtocol else { return }

        barGradientColorsNormal = style.lineBarGradientColorsNormal
        barGradientColorsSelected = style.lineBarGradientColorsSelected
        barInsets = style.lineBarInsets
        barCornerRadius = style.lineBarCornerRadius
    }
}
