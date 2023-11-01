//
//  LineChartSurface.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class LineChartSurface: CALayer, ChartSurfaceSelectableProtocol {

    // MARK: - Public Properties

    public var selectionIndex: Int?
    public var selectionTitle: String?

    // MARK: - Private Properties

    private var selectionBadgeVerticalSpacing: CGFloat = 16
    private var selectionPointOuterColor: UIColor = Colors.red01
    private var selectionPointInnerColor: UIColor = Colors.gray01
    private var selectionPointSize: CGFloat = 8
    private var selectionPointStrokeWidth: CGFloat {
        get { selectionLayer.lineWidth }
        set { selectionLayer.lineWidth = newValue }
    }

    private var applyCubicCurve = false
    private var lineWidth: CGFloat = 1 {
        didSet {
            shapeLayer.lineWidth = lineWidth
        }
    }
    private var lineColor: UIColor = .black {
        didSet {
            shapeLayer.strokeColor = lineColor.cgColor
        }
    }

    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 4
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.fillColor = Colors.clear.cgColor
        return shapeLayer
    }()

    private lazy var selectionLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 4
        shapeLayer.fillColor = Colors.clear.cgColor
        shapeLayer.isHidden = true
        return shapeLayer
    }()

    private lazy var selectionTextLayer: ChartSelectionLayer = {
        let layer = ChartSelectionLayer()
        layer.cornerRadius = 4
        layer.masksToBounds = true
        layer.isHidden = true
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
        shapeLayer.frame = bounds
        super.layoutSublayers()
    }

    // MARK: - Private methods

    private func initialSetup() {
        backgroundColor = Colors.clear.cgColor
        addSublayer(shapeLayer)
        addSublayer(selectionLayer)
        addSublayer(selectionTextLayer)
    }

    private func makeLinearPath(from points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        points.indices.forEach { index in
            let point = points[index]
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        return path
    }

    private func makeCubicCurvePath(from points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        guard points.count > 1, let pFirst = points.first, let pLast = points.last else { return path }

        var p1 = pFirst

        path.move(to: pFirst)
        guard points.count > 2 else {
            path.addLine(to: pLast)
            return path
        }

        var oldControlPoint: CGPoint?

        for i in 1 ..< points.count {
            let p2 = points[i]
            var p3: CGPoint?
            if i < points.count - 1 {
                p3 = points[i + 1]
            }

            let newControlPoint = p1.controlPoint(p2: p2, next: p3)

            path.addCurve(to: p2,
                          control1: oldControlPoint ?? p1,
                          control2: newControlPoint ?? p2)

            p1 = p2
            oldControlPoint = newControlPoint?.opposite(center: p2)
        }
        return path
    }
}

// MARK: - ChartSurfaceProtocol

extension LineChartSurface: ChartSurfaceProtocol {

    var surfaceType: ChartSurfaceType { .chart }

    func render(with dataProvider: ChartDataProviderProtocol) {
        guard let dataProvider = dataProvider as? ChartPointsProviderProtocol else { return }
        let points = dataProvider.normalizedVisiblePoints

        let rect = bounds

        let convertedPoints: [CGPoint] = points.indices.map { index in
            let x = points[index].0.x * rect.width + rect.minX
            let y = (1 - points[index].0.y) * rect.height + rect.minY
            return CGPoint(x: x, y: y)
        }

        if applyCubicCurve {
            shapeLayer.path = makeCubicCurvePath(from: convertedPoints)
        } else {
            shapeLayer.path = makeLinearPath(from: convertedPoints)
        }

        CATransaction.begin()
        CATransaction.setDisableActions(true)

        if let selectionIndex = selectionIndex, selectionIndex >= 0, selectionIndex < convertedPoints.count {
            let point = convertedPoints[selectionIndex]
            selectionLayer.frame = CGRect(x: point.x - selectionPointSize / 2,
                                          y: point.y - selectionPointSize / 2,
                                          width: selectionPointSize,
                                          height: selectionPointSize)
            selectionLayer.strokeColor = selectionPointOuterColor.cgColor
            selectionLayer.fillColor = selectionPointInnerColor.cgColor
            selectionLayer.isHidden = false

            let path = UIBezierPath(roundedRect: selectionLayer.bounds, cornerRadius: selectionPointSize / 2)
            selectionLayer.path = path.cgPath

            selectionTextLayer.text = selectionTitle
            selectionTextLayer.frame = CGRect(origin: getClosestOrigin(anchor: point, frameSize: selectionTextLayer.frame.size),
                                              size: selectionTextLayer.frame.size)
            selectionTextLayer.isHidden = false
        } else {
            selectionLayer.isHidden = true
            selectionTextLayer.isHidden = true
        }

        CATransaction.commit()
    }

    func applyStyle(_ style: ChartStyleProtocol) {
        if let style = style as? LineStyleProtocol {
            applyCubicCurve = style.lineSmoothing
            lineWidth = style.lineWidth
            lineColor = style.lineColor
        }
        if let style = style as? LineSelectionStyleProtocol {
            selectionPointOuterColor = style.selectionPointOuterColor
            selectionPointInnerColor = style.selectionPointInnerColor
            selectionPointSize = style.selectionPointSize
            selectionPointStrokeWidth = style.selectionPointStrokeWidth

            selectionTextLayer.selectionBackgroundCornerRadius = style.selectionBackgroundCornerRadius
            selectionTextLayer.selectionBackgroundColor = style.selectionBackgroundColor
            selectionTextLayer.selectionTextColor = style.selectionTextColor
            selectionTextLayer.selectionTextFont = style.selectionTextFont
            selectionTextLayer.titleInsets = style.selectionTextInsets
        }
    }

    private func getClosestOrigin(anchor: CGPoint, frameSize: CGSize) -> CGPoint {
        var x: CGFloat
        if anchor.x < bounds.width / 2 {
            x = anchor.x - frameSize.width
            if x < 0 {
                x = anchor.x
            }
        } else {
            x = anchor.x
            if x > bounds.width - frameSize.width {
                x = anchor.x - frameSize.width
            }
        }

        var y = anchor.y - frameSize.height - selectionBadgeVerticalSpacing
        if y < 0 {
            y = anchor.y + selectionBadgeVerticalSpacing
        }
        return CGPoint(x: x, y: y)
    }
}
