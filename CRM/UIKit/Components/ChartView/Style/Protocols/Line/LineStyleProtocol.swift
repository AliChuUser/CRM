//
//  LineStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol LineStyleProtocol {

    var lineSmoothing: Bool { get }
    var lineColor: UIColor { get }
    var lineWidth: CGFloat { get }
    var clampToLowestValue: Bool { get }
}
