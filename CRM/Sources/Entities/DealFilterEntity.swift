//
//  DealFilterEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class DealFilterEntity {

    var title: String
    var filterAction: (([DealEntity]) -> [DealEntity])

    init(title: String, filterAction: @escaping (([DealEntity]) -> [DealEntity])) {
        self.title = title
        self.filterAction = filterAction
    }
}
