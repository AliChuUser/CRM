//
//  ChartPointsProviderProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import Foundation

protocol ChartPointsProviderProtocol {

    var normalizedVisiblePoints: [(CGPoint, UIColor)] { get }
}
