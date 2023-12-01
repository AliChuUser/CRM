//
//  TableViewStructure.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

public struct TableViewSection {
    public var sectionHeaderView: UIView?
    public var cellModels: [TableBaseCellModel]

    public init(cellModels: [TableBaseCellModel]) {
        self.cellModels = cellModels
    }
}

public class TableViewStructure {

    public var sections = [TableViewSection]()

    public init() { }

    public func clear() {
        sections = [TableViewSection]()
    }

    public func addSection(section: TableViewSection) {
        sections.append(section)
    }

    public func cellModel(for indexPath: IndexPath) -> TableBaseCellModel {
        let sectionIndex = indexPath.section
        let rowIndex = indexPath.row
        let section = sections[sectionIndex]
        return section.cellModels[rowIndex]
    }

    public func indexPath(for model: TableBaseCellModel) -> IndexPath? {
        for sectionIndex in sections.indices {
            let section = sections[sectionIndex]
            for modelIndex in section.cellModels.indices {
                if section.cellModels[modelIndex] === model {
                    return IndexPath(row: modelIndex, section: sectionIndex)
                }
            }
        }
        return nil
    }

    public func addModel(_ model: TableBaseCellModel, inSection index: Int) {
        var newSections = [TableViewSection]()
        self.sections.indices.forEach { oldSectionIndex in
            var oldSection = self.sections[oldSectionIndex]
            if oldSectionIndex == index {
                oldSection.cellModels.append(model)
            }
            newSections.append(oldSection)
        }
        self.sections = newSections
    }
}
