//
//  TabContainerViewController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

open class TabContainerViewController: UIViewController {

		public var selectedIndex: Int? = nil {
				didSet {
						guard validate(index: selectedIndex) else {
								assertionFailure("Нет контроллера с таким индексом")
								selectedIndex = oldValue
								return
						}

						if isViewLoaded {
								showSelectedViewController()
						}
				}
		}

		public var viewControllers: [UIViewController]? {
				didSet {
						guard oldValue == nil else {
								assertionFailure("Пока можно присвоить только один раз")
								return
						}
						didSetup = false
				}
		}

		private var didSetup = false

		private var tabControl: TabControl?
		private lazy var contentView: UIView = { UIView() }()
		private weak var shownViewController: UIViewController?

		override open func viewDidLoad() {
				super.viewDidLoad()

				showSelectedViewController()
		}

		open func didShowViewController(at index: Int) {}

		private func setupIfNeeded() {
				assert(isViewLoaded)
				if didSetup { return }

				guard let viewControllers = self.viewControllers else {
						assertionFailure("Значение `viewControllers` должно быть задано к этому моменту")
						return
				}
				setup(for: viewControllers)
		}

		private func setup(for viewControllers: [UIViewController]) {
				assert(isViewLoaded)

				let titles = viewControllers.map { $0.tabBarItem.title ?? "" }
				viewControllers.forEach {
						$0.additionalSafeAreaInsets.top = TabControl.height
				}

				let tabControl = makeTabControl(titles: titles)
				tabControl.onTabSelected = { [weak self] (button, animated) in
						if let index = self?.tabControl?.buttons.firstIndex(of: button) {
								self?.selectedIndex = index
						}
				}
				let superview: UIView = view

				let contentView = self.contentView
				contentView.translatesAutoresizingMaskIntoConstraints = false
				superview.addSubview(contentView)

				tabControl.translatesAutoresizingMaskIntoConstraints = false
				superview.addSubview(tabControl)
				NSLayoutConstraint.activate([
						tabControl.topAnchor.constraint(equalTo: superview.topAnchor),
						tabControl.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
						tabControl.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
						tabControl.heightAnchor.constraint(equalToConstant: tabControl.bounds.height)
				])
				self.tabControl = tabControl

				NSLayoutConstraint.activate([
						contentView.topAnchor.constraint(equalTo: superview.topAnchor),
						contentView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
						contentView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
						contentView.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
				])

				didSetup = true
		}

		private func makeTabControl(titles: [String]) -> TabControl {
				let buttons = titles.map { (title) -> TabButton in
						let button = TabButton()
						button.setTitle(title, for: .normal)
						return button
				}
				let tabControl = TabControl(buttons: buttons, height: TabControl.height)
				tabControl.backgroundColor = Colors.white
				return tabControl
		}

		private func validate(index: Int?) -> Bool {
				guard let index = index else {
						return (viewControllers?.count ?? 0) == 0
				}

				let count = viewControllers?.count ?? 0
				guard 0 <= index, index < count else {
						return false
				}
				return true
		}

		private func showSelectedViewController() {
				guard let selectedIndex = selectedIndex else {
						return
				}

				assert(isViewLoaded)
				setupIfNeeded()

				guard let viewControllers = self.viewControllers else { return }

				let viewController = viewControllers[selectedIndex]

				if let shownViewController = shownViewController {
						if viewController == shownViewController {
								return
						} else {
								deinstall(shownViewController)
						}
				}

				install(viewController)
				shownViewController = viewController
				tabControl?.tapButton(with: selectedIndex)

				didShowViewController(at: selectedIndex)
		}

		private func install(_ viewController: UIViewController) {
				addChild(viewController)

				let view: UIView = viewController.view
				contentView.addSubview(view)
				view.frame = self.contentView.bounds
				view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

				viewController.didMove(toParent: self)
		}

		private func deinstall(_ viewController: UIViewController) {
				viewController.willMove(toParent: nil)
				viewController.view.removeFromSuperview()
				viewController.removeFromParent()
		}
}

