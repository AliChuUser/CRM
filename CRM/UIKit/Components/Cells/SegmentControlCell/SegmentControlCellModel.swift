//
//  SegmentControlCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation

public class SegmentControlCellModel: TableBaseCellModel {

    public var title: String?
    public var onSegmentChange: ((Int?) -> Void)?
    public var isSelectedSegment: Int = 0
    public var isDisabled: Bool = false

    public override var cellIdentifier: String {
        return String(describing: SegmentControlCell.self)
    }

    public init() {
        super.init(action: nil)
    }
}
