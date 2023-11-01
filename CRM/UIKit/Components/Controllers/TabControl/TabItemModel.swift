//
//  TabItemModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

public class TabItemModel {
		
		public var title: String
		public var isSelected: Bool
		public var action: () -> Void
		
		public init(title: String, isSelected: Bool, action: @escaping () -> Void) {
				self.title = title
				self.isSelected = isSelected
				self.action = action
		}
}
