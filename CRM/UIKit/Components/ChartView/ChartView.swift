//
//  ChartView.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

public class ChartView: UIControl {

    // MARK: - Public properties

    public var selectionEnabled: Bool = true

    public var model: ChartModel? {
        didSet {
            initialSetup()
        }
    }

    public var chartType: ChartType? {
        didSet {
            initialSetup()
        }
    }

    // MARK: - Internal properties

    var dataProvider: ChartDataProviderProtocol?
    var surfaces = [ChartSurfaceProtocol]()
    var style: ChartStyleProtocol?
    var lastSelectionIndex: Int?

    // MARK: - Lifecycle

    override public func layoutSubviews() {
        super.layoutSubviews()
        if let style = style {
            chartType?.layoutSurfaces(surfaces: surfaces, in: self, with: style)
        }
        redraw()
    }

    // MARK: - Public

    public func updateStyle() {
        guard let style = style else { return }
        backgroundColor = style.backgroundColor
        dataProvider?.applyStyle(style)
        surfaces.forEach { $0.applyStyle(style) }
    }

    public func updateData() {
        guard let dataProvider = dataProvider else { return }
        dataProvider.recalc()
    }

    public func redraw() {
        guard let dataProvider = dataProvider else { return }
        surfaces.forEach { surface in
            surface.render(with: dataProvider)
        }
    }

    // MARK: - Private

    private func initialSetup() {
        layer.backgroundColor = Colors.white.cgColor
        guard let model = model else {
            print("Failed to initialize dataProvider. model property is nil")
            return
        }
        guard let chartType = chartType else {
            print("Failed to initialize dataProvider. chartType property is nil")
            return
        }
        dataProvider = chartType.makeDataProvider(withModel: model)
        style = chartType.makeStyle()
        setupSurfaces()
        updateStyle()
        updateData()
        redraw()
    }

    private func setupSurfaces() {
        removeSurfaces()
        guard let chartType = chartType else { return }
        surfaces = chartType.makeSurfaces()
        surfaces.forEach {
            layer.addSublayer($0)
        }
    }

    private func removeSurfaces() {
        surfaces.forEach { $0.removeFromSuperlayer() }
    }
}

// MARK: - Touches

extension ChartView {

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard selectionEnabled else { return }

        let data = getSelectionData(from: touches)
        var index = data?.0
        if lastSelectionIndex == index {
            index = nil
        }
        surfaces.forEach {
            guard let surface = $0 as? ChartSurfaceSelectableProtocol else { return }
            surface.selectionIndex = index
            surface.selectionTitle = data?.1
        }
        redraw()
        lastSelectionIndex = index
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let data = getSelectionData(from: touches)
        guard data?.0 != lastSelectionIndex else {
            return
        }
        surfaces.forEach {
            guard let surface = $0 as? ChartSurfaceSelectableProtocol else { return }
            surface.selectionIndex = data?.0
            surface.selectionTitle = data?.1
        }
        redraw()
        lastSelectionIndex = data?.0
    }

    private func getSelectionData(from touches: Set<UITouch>) -> (Int, String)? {
        guard let dataProvider = dataProvider,
            let point = touches.first?.location(in: self),
            let touchSurface = surfaces.first(where: { $0.surfaceType == .chart })
        else {
            return nil
        }

        let normalizedPoint = CGPoint(x: (point.x - touchSurface.frame.minX) / touchSurface.frame.width,
                                      y: 1 - (point.y - touchSurface.frame.minY) / touchSurface.frame.height)

        guard CGRect(x: 0, y: 0, width: 1, height: 1).contains(normalizedPoint) else { return nil }

        return dataProvider.hitTest(normalizedPoint: normalizedPoint)
    }
}

