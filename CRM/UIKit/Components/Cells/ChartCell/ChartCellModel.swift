//
//  ChartCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation

public class ChartCellModel: TableBaseCellModel {

    public var chartType: ChartView.ChartType?
    public var chartModel: ChartModel?

    override public var cellIdentifier: String {
        return String(describing: ChartCell.self)
    }

    public init() {
        super.init(action: nil)
    }
}
