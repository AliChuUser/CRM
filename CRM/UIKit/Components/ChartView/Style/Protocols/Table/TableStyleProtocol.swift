//
//  TableStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol TableStyleProtocol {

    var tableValueGroupCount: Int { get }
    var tableValueColor: UIColor { get }
    var tableCellCornerRadius: CGFloat { get }
    var tableCellInsets: UIEdgeInsets { get }
}
