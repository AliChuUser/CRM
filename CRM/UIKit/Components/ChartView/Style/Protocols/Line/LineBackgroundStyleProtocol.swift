//
//  LineBackgroundStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol LineBackgroundStyleProtocol {

    var lineBarGradientColorsNormal: [UIColor] { get }
    var lineBarGradientColorsSelected: [UIColor] { get }
    var lineBarInsets: UIEdgeInsets { get }
    var lineBarCornerRadius: CGFloat { get }
}
