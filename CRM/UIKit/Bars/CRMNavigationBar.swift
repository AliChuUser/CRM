//
//  CRMNavigationBar.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import Foundation

public class CRMNavigationBar: UINavigationBar {
		
		override public init(frame: CGRect) {
				super.init(frame: frame)
				commonInit()
		}
		
		required public init?(coder: NSCoder) {
				super.init(coder: coder)
				commonInit()
		}

		override public func layoutSubviews() {
				super.layoutSubviews()
		}
		
		private func commonInit() {
				backgroundColor = Colors.white
				barTintColor = Colors.white
				tintColor = Colors.mainBlazer
				shadowImage = UIImage()
				isTranslucent = false
				prefersLargeTitles = false

				largeTitleTextAttributes = [
						NSAttributedString.Key.foregroundColor: Colors.dark,
						NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 23)!
				]

				titleTextAttributes = [
						NSAttributedString.Key.foregroundColor: Colors.dark,
						NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 17)!
				]
		}
		
}
