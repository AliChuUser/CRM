//
//  GradientView.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

@IBDesignable
public class GradientView: UIView {

		override public class var layerClass: AnyClass {
				return CAGradientLayer.self
		}

		@IBInspectable
		public var startX: CGFloat = 0 {
				didSet {
						resetGradient()
				}
		}

		@IBInspectable
		public var startY: CGFloat = 0 {
				didSet {
						resetGradient()
				}
		}

		@IBInspectable
		public var endX: CGFloat = 1 {
				didSet {
						resetGradient()
				}
		}

		@IBInspectable
		public var endY: CGFloat = 1 {
				didSet {
						resetGradient()
				}
		}

		@IBInspectable
		public var startColor: UIColor = .cyan {
				didSet {
						resetGradient()
				}
		}

		@IBInspectable
		public var endColor: UIColor = .orange {
				didSet {
						resetGradient()
				}
		}

		override public func prepareForInterfaceBuilder() {
				super.prepareForInterfaceBuilder()
				resetGradient()
		}

		override public func layoutSubviews() {
				super.layoutSubviews()
				resetGradient()
		}

		private func resetGradient() {
				guard let gradientLayer = layer as? CAGradientLayer else { return }
				gradientLayer.startPoint = CGPoint(x: startX, y: startY)
				gradientLayer.endPoint = CGPoint(x: endX, y: endY)
				gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
		}
}

