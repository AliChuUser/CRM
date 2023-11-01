//
//  HorizontalAxisStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol HorizontalAxisStyleProtocol {

    var horizontalAxisHorizontalAlignment: AxisTextHorizontalAlignment { get }
    var horizontalAxisVerticalAlignment: AxisTextVerticalAlignment { get }
    var horizontalTextColorNormal: UIColor { get }
    var horizontalTextFont: UIFont { get }
}
