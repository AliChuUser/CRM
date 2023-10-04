//
//  UIViewController+PullerStructure.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

public extension UIViewController {
		struct Holder {
				static var puller: PullerContainerViewController = PullerContainerViewController()
		}
		
		var puller: PullerContainerViewController {
				get {
						return Holder.puller
				}
				
				set(newPuller) {
						Holder.puller = newPuller
				}
		}
		
		func showPuller(withTitle: String? = nil, structure: TableViewStructure, header: UIView? = nil, footer: UIView? = nil) {
				let content = PullerListTableViewController()
				content.structure = structure
				content.header = header
				puller = addPuller(contentVC: content)

				content.onSelect = {
						print("SELECTED")
				}
		}
		
		func hidePuller() {
				puller.removePuller()
		}
}

