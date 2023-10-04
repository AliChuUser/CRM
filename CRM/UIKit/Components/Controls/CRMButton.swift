//
//  CRMButton.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import Foundation

public enum CRMButtonStyle {
		case solid
		case outlined
		case light
}

public class CRMButton: UIButton {
		
		private let backgroundColorEnabled = Colors.mainBlazer
		private let backgroundColorDisabled = Colors.disabledBlazer
		
		public var style: CRMButtonStyle = .solid {
				didSet {
						updateStyle()
				}
		}
		
		override public var isEnabled: Bool {
				didSet {
						updateStyle()
				}
		}
		
		override public func layoutSubviews() {
				super.layoutSubviews()
				layer.cornerRadius = bounds.height / 2
				updateStyle()
		}
		
		private func updateStyle() {
				switch style {
				case .solid:
						backgroundColor = isEnabled ? backgroundColorEnabled : backgroundColorDisabled
						layer.borderColor = Colors.clear.cgColor
						layer.borderWidth = 0
						
						setTitleColor(.white, for: .normal)
						setTitleColor(.white, for: .disabled)
				case .outlined:
						backgroundColor = Colors.clear
						layer.borderColor = isEnabled ? backgroundColorEnabled.cgColor : backgroundColorDisabled.cgColor
						layer.borderWidth = 1
						
						setTitleColor(backgroundColorEnabled, for: .normal)
						setTitleColor(backgroundColorDisabled, for: .disabled)
				case .light:
						backgroundColor = Colors.mainSilver
						layer.borderWidth = 0
						setTitleColor(.black, for: .normal)
						setTitleColor(.white, for: .disabled)
				}
		}
}
