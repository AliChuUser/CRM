//
//  CollectionBaseCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import UIKit

open class CollectionBaseCell: UICollectionViewCell {

    open weak var model: CollectionBaseCellModel?

    open var cellIdentifier: String {
        return String(describing: self)
    }

    open func setup(with model: CollectionBaseCellModel) {
        self.model = model
        updateAppearance()
    }

    open func updateAppearance() {

    }
}
