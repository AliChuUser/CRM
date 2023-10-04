//
//  TabControl.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

public class TabControl: UIScrollView, UIGestureRecognizerDelegate {

		public static let height: CGFloat = 66

		private let insetLeft: CGFloat = 16
		private let insetRight: CGFloat = 16
		private let insetTop: CGFloat = 16
		private let insetBottom: CGFloat = 16
		private let buttonSpacing: CGFloat = 8
		private let additionalButtonWidth: CGFloat = 32

		public var onTabSelected: ((TabButton, Bool) -> Void)?

		@objc public var buttons = [TabButton]()
		private var height: CGFloat
		private var names: [String]
		private var scrollBar: UIView?
		private weak var activeButton: TabButton?
		private var activatedButtonConstraints: [NSLayoutConstraint] = []
		var isDisabled: Bool = false {
				didSet {
						buttons.forEach { button in
								button.isUserInteractionEnabled = !self.isDisabled
						}
				}
		}
		public convenience init(buttons: [TabButton], height: CGFloat) {
				self.init(names: [], height: height)
				self.buttons = buttons

				self.reloadButtons()

				self.showsHorizontalScrollIndicator = false
				self.showsVerticalScrollIndicator = false
		}

		public init(names: [String],
								height: CGFloat) {

				self.height = height
				self.names = names

				super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))

				clearButtons()
				addButtons()
				addButtonsConstraints()
				if let firstButton = buttons.first {
						onTabSelected?(firstButton, false)
				}

				self.showsHorizontalScrollIndicator = false
				self.showsVerticalScrollIndicator = false
		}

		public func scroll(to activeButton: TabButton) {

				// текущая tab-кнопка должна подруливаться на середину
				if contentSize.width > frame.size.width {
						let xpos = activeButton.frame.origin.x
						let frameWidth  = frame.size.width
						let buttonWidth = activeButton.frame.size.width
						let contentWidth = contentSize.width
						let newpos = min(max(xpos - (frameWidth - buttonWidth)/2.0, 0), contentWidth - frameWidth)
						self.setContentOffset(CGPoint(x: newpos, y: 0), animated: true)
				}
		}

		public func tapButton(with index: Int) {
				if index < buttons.count {
						let button = buttons[index]
						activateButton(button)
						setBarPosition(offsetPercent: 0, page: index)
				}
		}

		internal func didSelectTabButton(_ button: TabButton) {
				activateButton(button)
				onTabSelected?(button, true)
		}

		private func activateButton(_ button: TabButton) {
				activeButton?.isActive = false
				button.isActive = true
				scroll(to: button)
				activeButton = button
		}

		public func setBarPosition(offsetPercent: CGFloat, page: Int) {
				if let scrollBar = scrollBar, buttons.count > 0 {
						var frame = scrollBar.frame

						// вперед
						if offsetPercent > 0,
								let currentButton = getButton(tab: page),
								let nextButton = getButton(tab: page + 1) {

								let diff = nextButton.frame.origin.x - currentButton.frame.origin.x
								frame.origin.x = currentButton.frame.origin.x + diff * offsetPercent
								scrollBar.frame = frame
								return
						}

						// назад
						if offsetPercent < 0,
								let currentButton = getButton(tab: page),
								let prevButton = getButton(tab: page - 1) {

								let diff = currentButton.frame.origin.x - prevButton.frame.origin.x
								frame.origin.x = currentButton.frame.origin.x + diff * offsetPercent
								scrollBar.frame = frame
								return
						}

						if offsetPercent == 0,
								let currentButton = getButton(tab: page) {
								frame.origin.x = currentButton.frame.origin.x
								scrollBar.frame = frame
								return
						}
				}
		}

		private func getButton(tab: Int) -> TabButton? {
				if tab < 0 {
						return buttons.first
				} else if tab >= buttons.count {
						return buttons.last
				} else {
						return buttons[tab]
				}
		}

		private func reloadButtons() {
				buttons.forEach { button in
						addSubview(button)
						button.action = { [weak self] in
								self?.didSelectTabButton(button)
						}
						button.translatesAutoresizingMaskIntoConstraints = false
				}
				addButtonsConstraints()
				if let firstButton = buttons.first {
						didSelectTabButton(firstButton)
				}
		}

		private func clearButtons() {
				buttons.forEach { $0.removeFromSuperview() }
				self.buttons.removeAll()
		}

		private func addButtons() {
				for i in 0 ..< names.count {
						let button = TabButton()
						button.setTitle(names[i], for: .normal)
						button.translatesAutoresizingMaskIntoConstraints = false
						button.action = { [weak self] in
								self?.didSelectTabButton(button)
						}
						buttons.append(button)
						addSubview(button)
				}
		}

		@objc public func setButtonTitle(_ title: String, at index: Int) {
				guard index >= 0 && index < buttons.count else {
						return
				}
				buttons[index].setTitle(title, for: .normal)
				addButtonsConstraints()
		}

		private func addButtonsConstraints() {
				UIView.deactivate(constraints: activatedButtonConstraints)
				activatedButtonConstraints.removeAll()

				for i in 0 ..< buttons.count {
						let button = buttons[i]
						guard let title = button.title(for: .normal), let font = button.titleLabel?.font else {
								continue
						}

						let width = title.widthOfString(usingFont: font) + additionalButtonWidth
						activatedButtonConstraints.append(pin(to: button, top: -insetTop))
						activatedButtonConstraints.append(pin(to: button, bottom: insetBottom))
						activatedButtonConstraints.append(button.pin(height: height - (insetBottom + insetTop)))
						activatedButtonConstraints.append(button.pin(width: width))
						if i == 0 {
								activatedButtonConstraints.append(pin(to: button, left: -insetLeft))
						}
						if i == buttons.count - 1 {
								activatedButtonConstraints.append(pin(to: button, right: insetRight))
						}
						if i > 0 {
								activatedButtonConstraints.append(pin(left: button, right: buttons[i - 1],
																											constant: buttonSpacing))
						}
				}
		}

		required init?(coder aDecoder: NSCoder) {
				fatalError("init(coder:) has not been implemented")
		}
}
