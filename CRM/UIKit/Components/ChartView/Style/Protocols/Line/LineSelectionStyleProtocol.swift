//
//  LineSelectionStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol LineSelectionStyleProtocol {

    var selectionPointInnerColor: UIColor { get }
    var selectionPointOuterColor: UIColor { get }
    var selectionPointSize: CGFloat { get }
    var selectionPointStrokeWidth: CGFloat { get }

    var selectionBackgroundCornerRadius: CGFloat { get }
    var selectionBackgroundColor: UIColor { get }
    var selectionTextColor: UIColor { get }
    var selectionTextFont: UIFont { get }
    var selectionTextInsets: UIEdgeInsets { get }
}
