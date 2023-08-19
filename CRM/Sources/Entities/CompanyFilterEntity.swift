//
//  CompanyFilterEntity.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class CompanyFilterEntity {

    var title: String
    var filterAction: (([CompanyEntity]) -> [CompanyEntity])

    init(title: String, filterAction: @escaping (([CompanyEntity]) -> [CompanyEntity])) {
        self.title = title
        self.filterAction = filterAction
    }
}
