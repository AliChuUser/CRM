//
//  UIViewController+Puller.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import Foundation

extension UIViewController {
		
		public func addPuller(contentVC: UIViewController) -> PullerContainerViewController {
				let puller = PullerContainerViewController()
				addChild(puller)
				let currentWindow = UIApplication.shared.keyWindow
				
				puller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
				currentWindow?.addSubview(puller.view)
				puller.didMove(toParent: self)
				currentWindow?.bringSubviewToFront(puller.view)
				
				puller.addPullerView(contentVC: contentVC)
				return puller
		}
}


public class PullerContainerViewController: UIViewController {
		
		private var pullerController: PullerViewController?
		private var backgroundShadow: UIView?
		
		func addPullerView(contentVC: UIViewController) {
				let backgroundShadowView = UIView()
				backgroundShadowView.frame = CGRect(x: 0,
																						y: 0,
																						width: self.view.frame.width,
																						height: self.view.frame.height)
				backgroundShadowView.tag = 100
				
				let pullerVC = PullerViewController()
				pullerVC.contentVC = contentVC
				pullerVC.onPositionChange = { (normalizedY: CGFloat) in
						backgroundShadowView.backgroundColor = UIColor(red: 35/255,
																													 green: 35/255,
																													 blue: 64/255,
																													 alpha: normalizedY)
				}
				
				self.backgroundShadow = backgroundShadowView
				self.pullerController = pullerVC
				
				self.view.addSubview(backgroundShadowView)
				self.addChild(pullerVC)
				self.view.addSubview(pullerVC.view)
				pullerVC.didMove(toParent: self)
				
				pullerVC.view.frame = CGRect(x: 0,
																		 y: self.view.frame.maxY,
																		 width: view.frame.width,
																		 height: view.frame.height)
				
				let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
				self.backgroundShadow?.addGestureRecognizer(tapGesture)
				self.backgroundShadow?.isUserInteractionEnabled = true
		}
		
		func removePuller() {
				pullerController?.removePullerFromSuperview()
		}
		
		@objc func tapHandler(gr: UITapGestureRecognizer) {
				removePuller()
		}
}
