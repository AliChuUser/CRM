//
//  TableChartSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class TableChartSurface: CALayer {

    // MARK: - Private Properties

    private var shapes = [CALayer]()
    private var cellCornerRadius: CGFloat = 2
    private var cellInsets = UIEdgeInsets.zero
    private var cellColor: UIColor = Colors.red01

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

extension TableChartSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        shapes.forEach { $0.removeFromSuperlayer() }

        guard let dataProvider = dataProvider as? ChartTableDataProviderProtocol else { return }
        let points = dataProvider.normalizedCellValues
        guard let first = points.first else { return }
        let rect = bounds
        let cellWidth = rect.width / CGFloat(points.count)
        let cellHeight = rect.height / CGFloat(first.count)

        points.indices.forEach { i in
            let xNorm = CGFloat(i) / CGFloat(points.count)
            points[i].indices.forEach { j in
                let yNorm = CGFloat(j) / CGFloat(points[i].count)
                let value = points[i][j]

                let layer = CAShapeLayer()
                layer.opacity = Float(value)
                layer.frame = CGRect(x: xNorm * rect.width,
                                     y: yNorm * rect.height,
                                     width: cellWidth,
                                     height: cellHeight).inset(by: cellInsets)
                layer.backgroundColor = cellColor.cgColor
                layer.cornerRadius = cellCornerRadius
                layer.masksToBounds = true

                addSublayer(layer)
                shapes.append(layer)
            }
        }
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        guard let style = style as? TableStyleProtocol else { return }

        cellColor = style.tableValueColor
        cellInsets = style.tableCellInsets
        cellCornerRadius = style.tableCellCornerRadius
    }
}
