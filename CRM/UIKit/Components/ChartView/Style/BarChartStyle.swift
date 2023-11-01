//
//  BarChartStyle.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

enum BarChartStyle: ChartStyleProtocol {

    case normal

    var chartInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return UIEdgeInsets(top: 16, left: 4, bottom: 4, right: 0)
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return Colors.clear
        }
    }
}

extension BarChartStyle: BarStyleProtocol {

    var barInsets: UIEdgeInsets {
        switch self {
        case .normal:
            return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    }

    var barCornerRadius: CGFloat {
        switch self {
        case .normal:
            return 2
        }
    }

    var barWidth: CGFloat? {
        switch self {
        case .normal:
            return 24
        }
    }
}

extension BarChartStyle: BarBackgroundStyleProtocol {

    var barBackgroundBottomLineColor: UIColor {
        switch self {
        case .normal:
            return Colors.gray01
        }
    }

    var barBackgroundLineColor: UIColor {
        switch self {
        case .normal:
            return Colors.gray03
        }
    }

    var barBackgroundLineWidth: CGFloat {
        switch self {
        case .normal:
            return 1
        }
    }

}

extension BarChartStyle: VerticalAxisStyleProtocol {

    var verticalAxisVerticalAlignment: AxisTextVerticalAlignment {
        switch self {
        case .normal:
            return .above
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
            return 3
        }
    }
}

