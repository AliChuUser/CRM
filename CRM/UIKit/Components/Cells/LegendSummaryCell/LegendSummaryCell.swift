//
//  LegendSummaryCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

class LegendSummaryCell: TableBaseCell {

    static var cellIdentifier = String(describing: self)

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        }
    }
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        }
    }

    override public func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? LegendSummaryCellModel else { return }

        titleLabel.text = model.title
        valueLabel.text = model.value
    }
}
