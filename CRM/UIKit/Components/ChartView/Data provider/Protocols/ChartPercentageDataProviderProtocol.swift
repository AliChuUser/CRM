//
//  ChartPercentageDataProviderProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import Foundation

protocol ChartPercentageDataProviderProtocol {

    var normalizedValues: [String: (CGFloat, UIColor)] { get }
}
