//
//  AxisTextHorizontalAlignment.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

enum AxisTextHorizontalAlignment {
    case left
    case right
    case centered

    var textAlignmentMode: CATextLayerAlignmentMode {
        switch self {
        case .left:
            return .left
        case .right:
            return .right
        case .centered:
            return .center
        }
    }
}
