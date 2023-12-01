//
//  TableCellSwipeAction.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

public class TableCellSwipeAction {

    public var title: String?
    public var backgroundColor: UIColor?
    public var icon: UIImage?

    public var action: (() -> Void)?

    public init() { }
}
