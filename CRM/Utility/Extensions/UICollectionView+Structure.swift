//
//  UICollectionView+Structure.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation
import UIKit

public extension UICollectionView {

    func numberOfSections(in structure: CollectionViewStructure) -> NSInteger {
        return structure.sections.count
    }

    func numberOfRows(in structure: CollectionViewStructure, section: NSInteger) -> NSInteger {
        guard section >= 0 && section < structure.sections.count else {
            return 0
        }
        return structure.sections[section].cellModels.count
    }

    func dequeueReusableCell(with structure: CollectionViewStructure, indexPath: IndexPath) -> CollectionBaseCell {
        let model = structure.cellModel(for: indexPath)
        let cell: CollectionBaseCell? = dequeueReusableCell(withReuseIdentifier: model.cellIdentifier, for: indexPath) as? CollectionBaseCell
        cell?.setup(with: model)
        return cell ?? CollectionBaseCell()
    }

}
