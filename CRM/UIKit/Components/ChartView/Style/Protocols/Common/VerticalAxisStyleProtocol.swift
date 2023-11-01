//
//  VerticalAxisStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol VerticalAxisStyleProtocol {

    var verticalAxisHorizontalAlignment: AxisTextHorizontalAlignment { get }
    var verticalAxisVerticalAlignment: AxisTextVerticalAlignment { get }
    var verticalTextColorNormal: UIColor { get }
    var verticalTextFont: UIFont { get }
    var verticalTitlesCount: Int { get }
}
