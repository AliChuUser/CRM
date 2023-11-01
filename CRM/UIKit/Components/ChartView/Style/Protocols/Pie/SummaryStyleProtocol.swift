//
//  SummaryStyleProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

protocol SummaryStyleProtocol {

    var summaryTitleFont: UIFont { get }
    var summarySubtitleFont: UIFont { get }

    var summaryTitleColor: UIColor { get }
    var summarySubtitleColor: UIColor { get }

    var summaryLabelsSpacing: CGFloat { get }
    var summaryInsets: UIEdgeInsets { get }
}
