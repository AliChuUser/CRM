//
//  PullerListTableViewController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

class PullerListTableViewController: UITableViewController {

		var onSelect: (() -> Void)?

		var structure: TableViewStructure? {
				didSet {
						tableView.separatorColor = Colors.clear
						tableView.reloadData()
				}
		}

		var header: UIView?
		
		override func viewDidLoad() {
				super.viewDidLoad()
				tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
				tableView.backgroundColor = Colors.snowWhite
				tableView.rowHeight = UITableView.automaticDimension
				tableView.estimatedRowHeight = 44
				tableView.separatorStyle = .singleLine
				tableView.showsVerticalScrollIndicator = false
				tableView.keyboardDismissMode = .onDrag
				tableView.register(UINib(nibName: "DetailsCell", bundle: Bundle(for: DetailsCell.self)), forCellReuseIdentifier: "DetailsCell")
				tableView.alwaysBounceVertical = false
		}
}


extension PullerListTableViewController {
		
		override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
				return UITableView.automaticDimension
		}

		override func numberOfSections(in tableView: UITableView) -> Int {
				guard let structure = structure else { return 0 }
				return tableView.numberOfSections(in: structure)
		}
		
		override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
				guard let structure = structure else { return nil }
				return tableView.viewForHeaderInSection(index: section, structure: structure)
		}
		
		override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
				guard let structure = structure else { return 0 }
				return tableView.heightForHeaderInSection(index: section, structure: structure)
		}
		
		override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
				guard let structure = structure else { return 0 }
				return tableView.numberOfRows(in: structure, section: section)
		}

		override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
				guard let structure = structure else { return UITableViewCell() }
				return tableView.dequeueReusableCell(with: structure, indexPath: indexPath)
		}

		override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
				guard let structure = structure else { return nil }
				return tableView.leadingSwipeActionsConfigurationForRowAt(indexPath: indexPath, structure: structure)
		}

		override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
				guard let structure = structure else { return nil }
				return tableView.trailingSwipeActionsConfigurationForRowAt(indexPath: indexPath, structure: structure)
		}

		override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
				//guard let model = structure?.cellModel(for: indexPath) else { return }
				onSelect?()
			//  model.action?()
		}
}

