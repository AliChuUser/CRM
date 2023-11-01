//
//  PieChartLegendSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class PieChartLegendSurface: CALayer {

    // MARK: - Private Properties

    private var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    private var subtitleFont: UIFont = UIFont.systemFont(ofSize: 10)
    private var insets: UIEdgeInsets = .zero
    private var labelSpacing: CGFloat = 0

    private var titleLayer: CATextLayer = {
        let layer = CATextLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.alignmentMode = .center
        layer.backgroundColor = Colors.clear.cgColor
        layer.isWrapped = true
        return layer
    }()

    private var subtitleLayer: CATextLayer = {
        let layer = CATextLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.alignmentMode = .center
        layer.backgroundColor = Colors.clear.cgColor
        layer.isWrapped = true
        return layer
    }()

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
        layoutLabels()
    }

    // MARK: - Private methods

    private func initialSetup() {
        backgroundColor = Colors.clear.cgColor

        addSublayer(titleLayer)
        addSublayer(subtitleLayer)
    }

    private func layoutLabels() {
        let rect = bounds.inset(by: insets)
        let rectSize = min(rect.width, rect.height)

        let titleHeight = (titleLayer.string as? String)?.height(usingFont: titleFont, constrainedToWidth: rectSize) ?? 0
        let subtitleHeight = (subtitleLayer.string as? String)?.height(usingFont: subtitleFont, constrainedToWidth: rectSize) ?? 0

        let totalHeight = titleHeight + labelSpacing + subtitleHeight
        let titleY = rect.minY + (rect.height - totalHeight) / 2
        let x = rect.minX + (rect.width - rectSize) / 2

        titleLayer.frame = CGRect(x: x, y: titleY, width: rectSize, height: titleHeight)
        subtitleLayer.frame = CGRect(x: x, y: titleLayer.frame.maxY + labelSpacing, width: rectSize, height: subtitleHeight)
    }
}

// MARK: - ChartSurfaceProtocol

extension PieChartLegendSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartSummaryDataProviderProtocol else { return }

        titleLayer.string = dataProvider.summaryTitle
        subtitleLayer.string = dataProvider.summarySubtitle

        titleLayer.font = titleFont
        titleLayer.fontSize = titleFont.pointSize

        subtitleLayer.font = subtitleFont
        subtitleLayer.fontSize = subtitleFont.pointSize

        layoutLabels()
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? SummaryStyleProtocol else { return }

        titleFont = style.summaryTitleFont
        subtitleFont = style.summarySubtitleFont

        titleLayer.foregroundColor = style.summaryTitleColor.cgColor
        subtitleLayer.foregroundColor = style.summarySubtitleColor.cgColor

        insets = style.summaryInsets
        labelSpacing = style.summaryLabelsSpacing
    }
}
