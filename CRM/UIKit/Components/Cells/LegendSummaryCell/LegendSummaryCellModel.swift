//
//  LegendSummaryCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation

public class LegendSummaryCellModel: TableBaseCellModel {

    public var title: String
    public var value: String

    override public var cellIdentifier: String {
        return String(describing: LegendSummaryCell.self)
    }

    public init(title: String, value: String) {
        self.title = title
        self.value = value
        super.init(action: nil)
    }
}
