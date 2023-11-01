//
//  ChartSurfaceSelectableProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol ChartSurfaceSelectableProtocol where Self: CALayer  {

    var selectionIndex: Int? { get set }
    var selectionTitle: String? { get set }
}
