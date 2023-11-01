//
//  PieChartStyle.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

enum PieChartStyle: ChartStyleProtocol {

    case normal

    var chartInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return .zero
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return Colors.clear
        }
    }
}

extension PieChartStyle: PieStyleProtocol {

    private var ringThickness: CGFloat { 32 }
    private var textInsets: CGFloat { 32 }

    var lineWidth: CGFloat {
        switch self {
        case .normal:
            return ringThickness
        }
    }
}

extension PieChartStyle: SummaryStyleProtocol {

    var summaryTitleFont: UIFont {
        switch self {
        case .normal:
            return UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }

    var summarySubtitleFont: UIFont {
        switch self {
        case .normal:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }

    var summaryTitleColor: UIColor {
        switch self {
        case .normal:
            return Colors.Charts.textDarkGrey
        }
    }

    var summarySubtitleColor: UIColor {
        switch self {
        case .normal:
            return Colors.Charts.textDarkGrey.withAlphaComponent(0.5)
        }
    }

    var summaryInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return UIEdgeInsets(top: ringThickness + textInsets,
                                left: ringThickness + textInsets,
                                bottom: ringThickness + textInsets,
                                right: ringThickness + textInsets)
        }
    }

    var summaryLabelsSpacing: CGFloat {
        switch self {
        case .normal:
            return 4
        }
    }
}

