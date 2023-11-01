//
//  HorizontalAxisSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class HorizontalAxisSurface: CALayer {

    // MARK: - Private Properties

    private var textColorNormal: UIColor = Colors.black01
    private var textFont: UIFont = UIFont.systemFont(ofSize: 8)
    private var textAlignment: CATextLayerAlignmentMode = .left
    private var textVerticalAlignment: AxisTextVerticalAlignment = .centered

    private var textLayers: [CATextLayer] = []

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

    override func layoutSublayers() {
        super.layoutSublayers()
    }

    // MARK: - Private methods

    private func initialSetup() {
        backgroundColor = Colors.clear.cgColor
    }

    private func resetLayers() {
        textLayers.forEach {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        }
        textLayers = []
    }
}

// MARK: - ChartSurfaceProtocol

extension HorizontalAxisSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .horizontalAxis }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartHorizontalAxisDataProviderProtocol else { return }
        let values = dataProvider.normalizedHorizontalValues

        resetLayers()
        guard values.count > 0 else { return }

        let rect = bounds
        let totalWidth = rect.width
        let itemWidth = totalWidth / CGFloat(values.count)
        let itemHeight = values.first?.1.height(usingFont: textFont, constrainedToWidth: itemWidth) ?? 0

        let yCorrection: CGFloat
        switch textVerticalAlignment {
        case .above:
             yCorrection = -itemHeight
        case .below:
            yCorrection = 0
        case .centered:
            yCorrection = -itemHeight / 2
        }
        let itemY = (bounds.height / 2) + yCorrection

        values.forEach { xNorm, title in
            let x = rect.minX + totalWidth * xNorm - itemWidth / 2

            let layer = CATextLayer()
            layer.isWrapped = true
            layer.contentsScale = UIScreen.main.scale
            layer.string = title
            layer.alignmentMode = textAlignment
            layer.font = textFont
            layer.fontSize = textFont.pointSize
            layer.foregroundColor = textColorNormal.cgColor
            layer.frame = CGRect(x: x, y: itemY, width: itemWidth, height: itemHeight)
            layer.backgroundColor = Colors.clear.cgColor
            addSublayer(layer)
            textLayers.append(layer)
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? HorizontalAxisStyleProtocol else { return }

        textColorNormal = style.horizontalTextColorNormal
        textFont = style.horizontalTextFont
        textAlignment = style.horizontalAxisHorizontalAlignment.textAlignmentMode
        textVerticalAlignment = style.horizontalAxisVerticalAlignment
    }
}
