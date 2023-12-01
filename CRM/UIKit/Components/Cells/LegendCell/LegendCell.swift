//
//  LegendCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

class LegendCell: TableBaseCell {

    static var cellIdentifier = String(describing: self)

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        }
    }
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        }
    }

    override public func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? LegendCellModel else { return }

        titleLabel.text = model.title
        valueLabel.text = model.value
        indicatorView.backgroundColor = model.indicatorColor
        separatorView.backgroundColor = model.separatorColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
    }
}
