//
//  PullerListViewController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

class PullerListViewController: UIViewController {
		
		@IBOutlet weak var headerView: UIView!
		
		var header: UIView?
		
		@IBOutlet weak var tableView: UITableView! {
				didSet {
						tableView.delegate = self
						tableView.dataSource = self
						tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
						tableView.backgroundColor = Colors.snowWhite
						tableView.separatorColor = Colors.clear
						tableView.rowHeight = UITableView.automaticDimension
						tableView.estimatedRowHeight = 44
						tableView.separatorStyle = .singleLine
						tableView.showsVerticalScrollIndicator = false
						tableView.keyboardDismissMode = .onDrag
						tableView.register(UINib(nibName: "DetailsCell", bundle: Bundle(for: DetailsCell.self)), forCellReuseIdentifier: "DetailsCell")
				}
		}
		
		@IBOutlet weak var footerView: UIView!
		
		var footer: UIView?
		
		var onSelect: (() -> Void)?
		
		var structure: TableViewStructure? {
				didSet {
						tableView?.reloadData()
				}
		}
		
		override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
				super.init(nibName: "PullerListViewController", bundle: Bundle(for: PullerListViewController.self))
		}
		
		required init?(coder: NSCoder) {
				fatalError("init(coder:) has not been implemented")
		}
		
		override func viewDidLoad() {
				super.viewDidLoad()
				if header != nil, headerView != nil {
						headerView.frame.size.height = 129
				}
				tableView.reloadData()
		}
}

extension PullerListViewController: UITableViewDelegate {
		
}

extension PullerListViewController: UITableViewDataSource {
		func numberOfSections(in tableView: UITableView) -> Int {
				guard let structure = structure else { return 0 }
				return tableView.numberOfSections(in: structure)
		}
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
				guard let structure = structure else { return 0 }
				return tableView.numberOfRows(in: structure, section: section)
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
				guard let structure = structure else { return UITableViewCell() }
				return tableView.dequeueReusableCell(with: structure, indexPath: indexPath)
		}
		
		func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
					//guard let model = structure?.cellModel(for: indexPath) else { return }
					//onSelect?()
				//  model.action?()
			}
}
