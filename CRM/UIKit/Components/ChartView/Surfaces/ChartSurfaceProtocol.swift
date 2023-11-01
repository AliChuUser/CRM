//
//  ChartSurfaceProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

enum ChartSurfaceType {
    case chart
    case legend
    case verticalAxis
    case horizontalAxis
}

protocol ChartSurfaceProtocol where Self: CALayer {

    var surfaceType: ChartSurfaceType { get }

    func applyStyle(_ style: ChartStyleProtocol)
    func render(with dataProvider: ChartDataProviderProtocol)
}
