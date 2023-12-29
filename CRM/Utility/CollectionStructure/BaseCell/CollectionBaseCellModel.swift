//
//  CollectionBaseCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import UIKit

open class CollectionBaseCellModel {

    open var cellIdentifier: String {
        return ""
    }

    open var action: () -> ()

    public init(action: @escaping () -> Void) {
        self.action = action
    }
}
