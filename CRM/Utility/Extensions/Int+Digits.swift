//
//  Int+Digits.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation

public extension Int {

    var numberOfDigits: Int {
        if self < 10 && self >= 0 || self > -10 && self < 0 {
            return 1
        } else {
            return 1 + (self / 10).numberOfDigits
        }
    }

    var nextRoundNumber: Int? {
        return roundNumber(upwards: true)
    }

    var previousRoundNumber: Int? {
        return roundNumber(upwards: false)
    }

    var isRound: Bool {
        if self == 0 { return true }
        return roundNumber(upwards: true) == self
    }

    private func roundNumber(upwards: Bool) -> Int? {
        let addition = upwards ? 1 : 0

        let digitsTotal = numberOfDigits
        var s = String("\(self)".prefix(1))

        let restNumber = String("\(self)").suffix(digitsTotal - 1)
        if Int(restNumber) == 0 {
            return self
        }
        guard let ns = Int(s) else { return nil }
        s = "\(ns + addition)"
        for _ in 1 ..< digitsTotal {
            s += "0"
        }

        return Int(s)
    }
}
