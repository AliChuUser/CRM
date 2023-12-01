//
//  TableBaseCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

open class TableBaseCellModel {

    open var cellIdentifier: String {
        return ""
    }

    open var action: (() -> Void)?
    open var userInteractionEnabled = true

    open var leftSwipeActions = [TableCellSwipeAction]()
    open var rightSwipeActions = [TableCellSwipeAction]()

    public init(action: (() -> Void)?) {
        self.action = action
    }
}
