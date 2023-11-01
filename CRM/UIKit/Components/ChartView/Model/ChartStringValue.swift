//
//  ChartStringValue.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

public class ChartStringValue {

    public var title: String
    public var value: Int
    public var color: UIColor

    public init(title: String, value: Int, color: UIColor) {
        self.title = title
        self.value = value
        self.color = color
    }
}
