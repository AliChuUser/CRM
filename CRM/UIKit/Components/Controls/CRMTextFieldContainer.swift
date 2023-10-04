//
//  CRMTextFieldContainer.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import Foundation

public class CRMTextFieldContainer: UIView {

		override public init(frame: CGRect) {
				super.init(frame: frame)
				commonInit()
		}
		
		required public init?(coder aDecoder: NSCoder) {
				super.init(coder: aDecoder)
				commonInit()
		}
		
		private func commonInit() {
				let bottomLine = CALayer()
				bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
				bottomLine.backgroundColor = Colors.mainSilver.cgColor
				layer.addSublayer(bottomLine)
				
				clipsToBounds = true
		}
}
