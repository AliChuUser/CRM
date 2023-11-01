//
//  BarStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol BarStyleProtocol {

    var barInsets: UIEdgeInsets { get }
    var barCornerRadius: CGFloat { get }
    var barWidth: CGFloat? { get }
}
