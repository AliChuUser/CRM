//
//  CRMToolBar.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import Foundation

@IBDesignable
public class CRMToolBar: UIToolbar {

		override public func awakeFromNib() {
				super.awakeFromNib()
				setupStyle()
		}

		override public func prepareForInterfaceBuilder() {
				super.prepareForInterfaceBuilder()
				setupStyle()
		}

		private func setupStyle() {
				barTintColor = Colors.snowWhite
				backgroundColor = Colors.snowWhite
				tintColor = Colors.accentPurpleDefault
				isTranslucent = false
				setShadowImage(UIImage(), forToolbarPosition: .any)
				layer.shadowColor = Colors.toolbarShadow.cgColor
				layer.shadowRadius = 26
				layer.shadowOffset = CGSize(width: 0, height: -3)
				layer.shadowOpacity = 1
		}
}
