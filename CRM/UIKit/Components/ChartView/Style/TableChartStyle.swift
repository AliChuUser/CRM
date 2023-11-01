//
//  TableChartStyle.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

enum TableChartStyle: ChartStyleProtocol {

    case normal

    var chartInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return UIEdgeInsets(top: 0, left: 8, bottom: 4, right: 0)
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return Colors.clear
        }
    }
}

extension TableChartStyle: TableStyleProtocol {

    var tableValueGroupCount: Int {
        switch self {
        case .normal:
            return 4
        }
    }

    var tableValueColor: UIColor {
        switch self {
        case .normal:
            return Colors.green01
        }
    }

    var tableCellCornerRadius: CGFloat {
        switch self {
        case .normal:
            return 2
        }
    }

    var tableCellInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        }
    }
}

extension TableChartStyle: TableLegendStyleProtocol {

    var tableLegendTextColor: UIColor {
        switch self {
        case .normal:
            return Colors.black01
        }
    }

    var tableLegendTextFont: UIFont {
        switch self {
        case .normal:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }

    var tableLegendTitleInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    }
}

extension TableChartStyle: VerticalAxisStyleProtocol {

    var verticalAxisVerticalAlignment: AxisTextVerticalAlignment {
        switch self {
        case .normal:
            return .centered
        }
    }

    var verticalAxisHorizontalAlignment: AxisTextHorizontalAlignment {
        switch self {
        case .normal:
            return .right
        }
    }

    var verticalTextColorNormal: UIColor {
        switch self {
        case .normal:
            return Colors.Charts.textLightGrey
        }
    }

    var verticalTextFont: UIFont {
        switch self {
        case .normal:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }

    var verticalTitlesCount: Int {
        switch self {
        case .normal:
            return 0
        }
    }
}

extension TableChartStyle: HorizontalAxisStyleProtocol {

    var horizontalAxisHorizontalAlignment: AxisTextHorizontalAlignment {
        switch self {
        case .normal:
            return .centered
        }
    }

    var horizontalAxisVerticalAlignment: AxisTextVerticalAlignment {
        switch self {
        case .normal:
            return .centered
        }
    }

    var horizontalTextColorNormal: UIColor {
        switch self {
        case .normal:
            return Colors.Charts.textLightGrey
        }
    }

    var horizontalTextFont: UIFont {
        switch self {
        case .normal:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }
}

