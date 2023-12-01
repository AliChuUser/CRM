//
//  TableBaseCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

open class TableBaseCell: UITableViewCell {

    open weak var model: TableBaseCellModel?

    open var cellIdentifier: String {
        return String(describing: self)
    }

    open func setup(with model: TableBaseCellModel) {
        self.model = model
        updateAppearance()
    }

    open func updateAppearance() {
        isUserInteractionEnabled = model?.userInteractionEnabled ?? true
        selectionStyle = .none
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        let gr = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        gr.cancelsTouchesInView = false
        addGestureRecognizer(gr)
    }

    @objc private func cellTap() {
        model?.action?()
        isUserInteractionEnabled = model?.userInteractionEnabled ?? true
    }
}
