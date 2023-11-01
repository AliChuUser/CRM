//
//  VerticalAxisSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class VerticalAxisSurface: CALayer {

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

extension VerticalAxisSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .verticalAxis }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartVerticalAxisDataProviderProtocol else { return }
        let values = dataProvider.normalizedVerticalValues

        resetLayers()
        guard values.count > 0 else { return }

        let itemHeight = values.first?.1.height(usingFont: textFont, constrainedToWidth: bounds.width) ?? 0

        values.forEach { yNorm, title in
            let yCorrection: CGFloat
            switch textVerticalAlignment {
            case .above:
                 yCorrection = -itemHeight
            case .below:
                yCorrection = 0
            case .centered:
                yCorrection = -itemHeight / 2
            }
            let itemY = yNorm * bounds.height + yCorrection

            let layer = CATextLayer()
            layer.isWrapped = true
            layer.contentsScale = UIScreen.main.scale
            layer.string = title
            layer.alignmentMode = textAlignment
            layer.font = textFont
            layer.fontSize = textFont.pointSize
            layer.foregroundColor = textColorNormal.cgColor
            layer.frame = CGRect(x: 0, y: itemY, width: bounds.width, height: itemHeight)
            layer.backgroundColor = Colors.clear.cgColor
            addSublayer(layer)
            textLayers.append(layer)
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? VerticalAxisStyleProtocol else { return }

        textColorNormal = style.verticalTextColorNormal
        textFont = style.verticalTextFont
        textAlignment = style.verticalAxisHorizontalAlignment.textAlignmentMode
        textVerticalAlignment = style.verticalAxisVerticalAlignment
    }
}
