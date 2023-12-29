//
//  UITableView+Structure.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation

public extension UITableView {

    func numberOfSections(in structure: TableViewStructure) -> NSInteger {
        return structure.sections.count
    }

    func numberOfRows(in structure: TableViewStructure, section: NSInteger) -> NSInteger {
        guard section >= 0 && section < structure.sections.count else {
            return 0
        }
        return structure.sections[section].cellModels.count
    }

    func dequeueReusableCell(with structure: TableViewStructure, indexPath: IndexPath) -> TableBaseCell {
        let model = structure.cellModel(for: indexPath)
        var cell: TableBaseCell? = dequeueReusableCell(withIdentifier: model.cellIdentifier) as? TableBaseCell
        if cell == nil {
            let bundle = Bundle(for: type(of: model))
            let nib = UINib(nibName: model.cellIdentifier, bundle: bundle)
            register(nib, forCellReuseIdentifier: model.cellIdentifier)
            cell = dequeueReusableCell(withIdentifier: model.cellIdentifier) as? TableBaseCell
        }
        cell!.setup(with: model)
        return cell!
    }

    func leadingSwipeActionsConfigurationForRowAt(indexPath: IndexPath, structure: TableViewStructure) -> UISwipeActionsConfiguration? {
        let model = structure.cellModel(for: indexPath)
        let actionModels = model.leftSwipeActions
        let actions: [UIContextualAction] = actionModels.map { makeContextualAction(from: $0) }
        let configuration = UISwipeActionsConfiguration(actions: actions)

        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    func trailingSwipeActionsConfigurationForRowAt(indexPath: IndexPath, structure: TableViewStructure) -> UISwipeActionsConfiguration? {
        let model = structure.cellModel(for: indexPath)
        let actionModels = model.rightSwipeActions
        let actions: [UIContextualAction] = actionModels.map { makeContextualAction(from: $0) }
        let configuration = UISwipeActionsConfiguration(actions: actions)
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    func viewForHeaderInSection(index: Int, structure: TableViewStructure) -> UIView? {
        guard index >= 0, index < structure.sections.count else { return nil }
        return structure.sections[index].sectionHeaderView
    }

    func heightForHeaderInSection(index: Int, structure: TableViewStructure) -> CGFloat {
        guard index >= 0, index < structure.sections.count else { return 0 }
        if let view = structure.sections[index].sectionHeaderView {
            return view.intrinsicContentSize.height
        } else {
            return 0
        }
    }

    private func makeContextualAction(from model: TableCellSwipeAction) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: model.title) { (action, view, completionHandler) in
           model.action?()
           completionHandler(true)
        }
        if let cgImageX =  model.icon?.cgImage {
             action.image = ImageWithoutRender(cgImage: cgImageX, scale: UIScreen.main.nativeScale, orientation: .up)
        }
        action.backgroundColor = model.backgroundColor
        return action
    }
}
