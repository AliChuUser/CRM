//
//  CollectionViewStructure.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import UIKit

public struct CollectionViewSection {
    public var cellModels: [CollectionBaseCellModel]

    public init(cellModels: [CollectionBaseCellModel]) {
        self.cellModels = cellModels
    }
}

public class CollectionViewStructure {

    public var sections = [CollectionViewSection]()

    public init() { }

    public func clear() {
        sections = [CollectionViewSection]()
    }

    public func addSection(section: CollectionViewSection) {
        sections.append(section)
    }

    public func cellModel(for indexPath: IndexPath) -> CollectionBaseCellModel {
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        let section = sections[sectionIndex]
        return section.cellModels[rowIndex]
    }
}
