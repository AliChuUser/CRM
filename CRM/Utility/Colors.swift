//
//  Colors.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation
import UIKit

public extension UIColor {

    convenience init(_ hex: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255.0, green: CGFloat((hex >> 8) & 0xFF) / 255.0, blue: CGFloat((hex) & 0xFF) / 255.0, alpha: CGFloat(255 * alpha) / 255)
    }

    convenience init(_ hexString: String, alpha: Double = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }

        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
    }

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: (r / 255), green: (g / 255), blue: (b / 255), alpha: a)
    }
}


public struct Colors {

    public static let black = UIColor("000")
    public static let white = UIColor("FFF")
    public static let clear = UIColor.clear


    public static let snowWhite = UIColor("FFF")
    public static let mainBlazer = UIColor("232340")
    public static let mainSilver = UIColor("F4F4F7")

    public static let tabLine = UIColor("DDDDE7")
    public static let disabledBlazer = UIColor("A2A2BD")
    public static let secondBlazer = UIColor("70708F")

    public static let hoverWhiteObject = UIColor("C6C6D2")

    public static let accentPurpleDefault = UIColor("2E5B9F")
    public static let accentYellowDefault = UIColor("A7750C")
    public static let accentMintDefault = UIColor("69E3E8")
    public static let accentRedDefault = UIColor("C43643")
    public static let accentGreenDefault = UIColor("16635D")
    public static let notificationError = UIColor("E62632")

    public static let textSecondary = UIColor("70708F")
    public static let textAccent = UIColor("E62632")
    public static let textSubtitle = UIColor("9393B0")
    public static let textGrey = UIColor("8F8F9F")

    public static let icnDefault = UIColor("A2A2BD")
    public static let icnActive = UIColor("232340")
    public static let icnGreyDisabled = UIColor("DDDDE7")
    public static let icnWhiteDefault = UIColor("FFF").withAlphaComponent(0.64)
    public static let icnWhiteHover = UIColor("FFF")
    public static let icnRed = UIColor("E62632")
    public static let icnYellow = UIColor("F8C44E")
    public static let veryLightBlue = UIColor("E4EDFF")
    public static let lightPink = UIColor("FFEDEE")
    public static let offWhite = UIColor("EDFFE6")
    public static let dodgerBlue = UIColor("3E80FF")
    public static let blueyGrey = UIColor("8F8F9F")
    public static let paleGrey = UIColor("F3F3F8")
    public static let dark = UIColor("25252E")
    public static let coralPink = UIColor("FE565A")
    public static let paleLilac = UIColor("E6E6F1")
    public static let palePurple = UIColor("A2A2BD")
    public static let lightBlueGrey = UIColor("C6C6CC")
    public static let lightGreen = UIColor("F1FEE8")
    public static let lightOrange = UIColor("FDF1DB")
    public static let lightBlue = UIColor("E8F0FF")
    public static let lightRed = UIColor("FEE1DD")
    public static let lightBlueGreyTwo = UIColor("BDC5E6")

    public static let pullerShadow = UIColor("232340").withAlphaComponent(0.5)
    public static let tabBarShadow = UIColor("A5A5A5").withAlphaComponent(0.07)
    public static let toolbarShadow = UIColor("A2A2BD").withAlphaComponent(0.18)

    public static let statusGradientBlue = (UIColor("5697FF"), UIColor("8AB3FF"))
    public static let statusGradientRed = (UIColor("F85155"), UIColor("FF7D81"))
    public static let statusGradientYellow = (UIColor("F5AF3C"), UIColor("FFC773"))
    public static let statusGradientGreen = (UIColor("58D69E"), UIColor("0DBD93"))

    public static let selectedTabBarItem = UIColor("#25252E").withAlphaComponent(0.9)
    public static let unselectedTabBarItem = UIColor("BAC5E9")

    public static let separatorLine = UIColor("DDDDE7")

    // MARK: - ChartView

    public static let black01 = UIColor("#0B1C35")

    public static let green01 = UIColor("#19BB4F")
    public static let green02 = UIColor("#107F8C")

    public static let red01 = UIColor("#E93223")
    public static let yellow01 = UIColor("#FAD155")

    public static let gray01 = UIColor("#CCCCCC")
    public static let gray02 = UIColor("#DBDBDB")
    public static let gray03 = UIColor("#F0F0F0")
    public static let gray70 = UIColor("#B3B3B3")

    public static let shadow01 = UIColor(white: 0.894, alpha: 1)
    public static let textGray = UIColor(white: 0.3, alpha: 1)

    public struct Charts {
        public static let textLightGrey = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        public static let textDarkGrey = UIColor(red: 0.043, green: 0.11, blue: 0.208, alpha: 1)
        public static let lineDefault = UIColor.black
        public static let gradientLight = [Colors.white.withAlphaComponent(0),
                                           UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 0.4)]
        public static let gradientDark = [Colors.white.withAlphaComponent(0),
                                          UIColor(red: 0.043, green: 0.11, blue: 0.208, alpha: 0.1)]

        public static let pieShadow = UIColor(white: 0, alpha: 0.15)
    }
}
