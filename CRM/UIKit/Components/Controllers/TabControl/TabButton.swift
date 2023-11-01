//
//  TabButton.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

public class TabButton: UIButton {

		var isActive = false {
				didSet {
						updateState()
				}
		}

		public var action: (() -> ())?

		public init() {
				super.init(frame: .zero)
				updateState()
				addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
		}

		required init?(coder aDecoder: NSCoder) {
				super.init(coder: aDecoder)
		}

		override public func layoutSubviews() {
				super.layoutSubviews()
				layer.cornerRadius = bounds.height / 2
		}

		@objc func tapButton(_ button: TabButton) {
				action?()
		}

		private func updateState() {
				if isActive {
						backgroundColor = Colors.mainBlazer
						setTitleColor(Colors.snowWhite, for: .normal)
				} else {
						backgroundColor = Colors.clear
						setTitleColor(Colors.dark, for: .normal)
				}
		}
}

