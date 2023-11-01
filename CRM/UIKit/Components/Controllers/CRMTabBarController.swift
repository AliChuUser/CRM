//
//  CRMTabBarController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

public class CRMTabBarController: UITabBarController, UITabBarControllerDelegate {
		
		private var indicatorLeading: NSLayoutConstraint?
		private var indicatorWidth: NSLayoutConstraint?
		
		required public init(coder: NSCoder) {
				super.init(coder: coder)!
				commonInit()
		}
		
		override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
				super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
				commonInit()
		}
		
		override public func awakeFromNib() {
				super.awakeFromNib()
				commonInit()
		}
		
		private func commonInit() {
				delegate = self
				tabBar.barTintColor = Colors.white
				setTabBarStyle()
				setTabBarItemFont()
		}
		
		private func setTabBarStyle() {
				tabBar.layer.masksToBounds = false
				
				let tabGradientView = UIView(frame: (tabBar.bounds))
				tabGradientView.backgroundColor = Colors.white
				tabGradientView.translatesAutoresizingMaskIntoConstraints = false;
				
				tabBar.addSubview(tabGradientView)
				tabBar.sendSubviewToBack(tabGradientView)
				tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
				
				tabBar.layer.shadowColor = Colors.tabBarShadow.cgColor
				tabBar.layer.shadowRadius = 15 // Blur
				tabBar.layer.shadowOpacity = 1
				tabBar.layer.shadowOffset = CGSize(width: 0, height: 3) // X Y
				
				if #available(iOS 13, *) {
						let appearance = tabBar.standardAppearance.copy()
						appearance.backgroundImage = UIImage()
						appearance.shadowImage = UIImage()
						appearance.shadowColor = Colors.clear
						tabBar.standardAppearance = appearance
				} else {
						tabBar.shadowImage = UIImage()
						tabBar.backgroundImage = UIImage()
				}
		}
		
		private func setTabBarItemFont() {
				let selectedColor = Colors.selectedTabBarItem
				let unselectedColor = Colors.unselectedTabBarItem
				if #available(iOS 13, *) {
						let appearance = tabBar.standardAppearance.copy()
						appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
						appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
						tabBar.standardAppearance = appearance
				} else {
						tabBar.tintColor = selectedColor
						tabBar.unselectedItemTintColor = unselectedColor
						
				}
		}
		
		override public func viewDidLayoutSubviews() {
				super.viewDidLayoutSubviews()
		}
}

extension UITabBar {
		override open func sizeThatFits(_ size: CGSize) -> CGSize {
				super.sizeThatFits(size)
				guard let window = UIApplication.shared.keyWindow else {
						return super.sizeThatFits(size)
				}
				var sizeThatFits = super.sizeThatFits(size)
				sizeThatFits.height = window.safeAreaInsets.bottom + 54
				return sizeThatFits
		}
}


extension CRMTabBarController {
		
		public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
				guard let actionViewController = viewController as? TabActionViewController else { return true }
				actionViewController.tabItemAction?()
				return false
		}
		
//    override public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        super.tabBar(tabBar, didSelect: item)
//        print("Selected item=", tabBar.items)
//    }
}

public class TabActionViewController: UIViewController {
		public var tabItemAction: (() -> Void)?
}

