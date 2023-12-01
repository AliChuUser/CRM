//
//  LegendCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation

public class LegendCellModel: TableBaseCellModel {

    public var title: String
    public var value: String
    public var indicatorColor: UIColor
    public var separatorColor = Colors.gray02

    override public var cellIdentifier: String {
        return String(describing: LegendCell.self)
    }

    public init(title: String, value: String, color: UIColor) {
        self.title = title
        self.value = value
        self.indicatorColor = color
        super.init(action: nil)
    }
}
