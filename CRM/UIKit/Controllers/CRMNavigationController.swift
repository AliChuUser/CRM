//
//  CRMNavigationController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

open class CRMNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

		/// View для перекрытия _UIParallaxDimmingView при транзишнах между дочерними контроллерами
		private var overlayView: UIView?

		override public init(navigationBarClass: AnyClass? = CRMNavigationBar.self, toolbarClass: AnyClass? = nil) {
				super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
				commonInit()
		}

		required public init?(coder aDecoder: NSCoder) {
				super.init(coder: aDecoder)
				commonInit()
		}

		override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
				super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
				commonInit()
		}

		override public func viewDidLoad() {
				super.viewDidLoad()
				commonInit()
		}

		private func commonInit() {
				interactivePopGestureRecognizer?.delegate = self
				delegate = self
				view.backgroundColor = Colors.white
				
				if #available(iOS 13.0, *) {
						let silverNavAppearance = UINavigationBarAppearance()
						silverNavAppearance.configureWithOpaqueBackground()
						silverNavAppearance.backgroundColor = Colors.mainSilver
						silverNavAppearance.shadowImage = UIImage()
						silverNavAppearance.shadowColor = .clear
						
						let whiteNavAppearance = UINavigationBarAppearance()
						whiteNavAppearance.configureWithOpaqueBackground()
						whiteNavAppearance.backgroundColor = Colors.white
						whiteNavAppearance.shadowImage = UIImage()
						whiteNavAppearance.shadowColor = .clear
						
						navigationBar.standardAppearance = whiteNavAppearance
						navigationBar.scrollEdgeAppearance = silverNavAppearance
						
						navigationBar.setBackgroundImage(UIImage(), for: .default)
						navigationBar.layer.borderColor = UIColor.clear.cgColor
						navigationBar.shadowImage = UIImage()
				}
				
				navigationBar.setValue(true, forKey: "hidesShadow")
				self.extendedLayoutIncludesOpaqueBars = true
		}

		public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {

				guard viewControllers.count > 1 else {
						viewController.navigationItem.leftBarButtonItem = nil
						return
				}
				
				if let vc = viewController as? CRMNavigationControllerConfigurable {
						if vc.overridesBackButton == false {
								makeBackArrow(at: viewController)
						}
				} else {
						makeBackArrow(at: viewController)
				}
		}
		
		private func makeBackArrow(at viewController: UIViewController) {
				let image = UIImage(named: "leftArrow")
				let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backTap))

				viewController.navigationItem.leftBarButtonItem = backButton
				viewController.navigationItem.leftBarButtonItem?.tintColor = Colors.mainBlazer
		}

		@objc private func backTap() {
				popViewController(animated: true)
		}

		public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
				return self.viewControllers.count > 1
		}
}

