//
//  TableLegendSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class TableLegendSurface: CALayer {

    // MARK: - Private Properties

    private var shapes = [CALayer]()
    private var titles = [CATextLayer]()

    private var cellCornerRadius: CGFloat = 2
    private var cellInsets = UIEdgeInsets.zero
    private var cellColor: UIColor = Colors.green01
    private var valueGroupCount: Int = 0

    private var textColor: UIColor = Colors.black01
    private var textFont: UIFont = UIFont.systemFont(ofSize: 8)
    private var textInsets: UIEdgeInsets = .zero

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

extension TableLegendSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .legend }

    func render(with dataProvider: ChartDataProviderProtocol) {
        shapes.forEach { $0.removeFromSuperlayer() }
        titles.forEach { $0.removeFromSuperlayer() }

        guard let dataProvider = dataProvider as? ChartTableLegendDataProviderProtocol else { return }

        let rect = bounds
        let cellWidth = rect.width / CGFloat(dataProvider.normalizedLegendCellData.count - 1)

        dataProvider.normalizedLegendCellData.indices.forEach { i in
            let title = dataProvider.normalizedLegendCellData[i]
            let height = title.height(usingFont: textFont) + textInsets.top + textInsets.bottom
            let width = title.width(usingFont: textFont) + textInsets.left + textInsets.right
            let isLast = i == dataProvider.normalizedLegendCellData.count - 1

            var textX = CGFloat(i) / CGFloat(dataProvider.normalizedLegendCellData.count - 1) * rect.width
            if i == 0 {
                // Оставляем выравнивание по левому краю
            } else if isLast {
                textX -= width
            } else {
                textX -= width / 2
            }
            let titleFrame = CGRect(x: textX,
                                    y: 0,
                                    width: width,
                                    height: height)

            let titleLayer = CATextLayer()
            titleLayer.contentsScale = UIScreen.main.scale
            titleLayer.string = title
            titleLayer.alignmentMode = .center
            titleLayer.font = textFont
            titleLayer.fontSize = textFont.pointSize
            titleLayer.foregroundColor = textColor.cgColor
            titleLayer.frame = titleFrame.inset(by: textInsets)
            titleLayer.backgroundColor = Colors.clear.cgColor
            addSublayer(titleLayer)
            titles.append(titleLayer)

            guard !isLast else { return }

            let cellFrame = CGRect(x: CGFloat(i) / CGFloat(dataProvider.normalizedLegendCellData.count - 1) * rect.width,
                                   y: titleFrame.maxY,
                                   width: cellWidth,
                                   height: rect.height - titleFrame.maxY)
            let layer = CAShapeLayer()
            layer.opacity = Float(i + 1) / Float(dataProvider.normalizedLegendCellData.count)
            layer.frame = cellFrame.inset(by: cellInsets)
            layer.backgroundColor = cellColor.cgColor
            layer.cornerRadius = cellCornerRadius
            layer.masksToBounds = true

            addSublayer(layer)
            shapes.append(layer)
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        if let style = style as? TableStyleProtocol {
            valueGroupCount = style.tableValueGroupCount
            cellColor = style.tableValueColor
            cellInsets = style.tableCellInsets
            cellCornerRadius = style.tableCellCornerRadius
        }
        if let style = style as? TableLegendStyleProtocol {
            textColor = style.tableLegendTextColor
            textFont = style.tableLegendTextFont
            textInsets = style.tableLegendTitleInsets
        }
    }
}
