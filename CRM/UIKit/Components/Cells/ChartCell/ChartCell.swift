//
//  ChartCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import UIKit

public class ChartCell: TableBaseCell {

    static var cellIdentifier = String(describing: self)

    @IBOutlet weak var chartView: ChartView!

    override public func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? ChartCellModel else { return }
        chartView.model = model.chartModel
        chartView.chartType = model.chartType

        clipsToBounds = false
        contentView.clipsToBounds = false
    }
}
