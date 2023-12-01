//
//  CheckboxCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation

public class CheckboxCellModel: TableBaseCellModel {

    public var title: String?

    public override var cellIdentifier: String {
        return String(describing: CheckboxCell.self)
    }

    public init() {
        super.init(action: nil)
    }
}
