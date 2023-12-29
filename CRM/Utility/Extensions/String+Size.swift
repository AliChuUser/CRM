//
//  String+Size.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation
import UIKit

public extension String {

    func width(usingFont font: UIFont) -> CGFloat {
         let fontAttributes = [NSAttributedString.Key.font: font]
         let size = self.size(withAttributes: fontAttributes)
         return size.width
     }

     func height(usingFont font: UIFont) -> CGFloat {
         let fontAttributes = [NSAttributedString.Key.font: font]
         let size = self.size(withAttributes: fontAttributes)
         return size.height
     }

     func size(usingFont font: UIFont) -> CGSize {
         let fontAttributes = [NSAttributedString.Key.font: font]
         return self.size(withAttributes: fontAttributes)
     }

     func width(usingFont font: UIFont, constrainedToHeight height: CGFloat) -> CGFloat {
         let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
         let boundingBox = self.boundingRect(with: constraintRect,
                                             options: .usesLineFragmentOrigin,
                                             attributes: [.font: font],
                                             context: nil)

         return ceil(boundingBox.width)
     }

     func height(usingFont font: UIFont, constrainedToWidth width: CGFloat) -> CGFloat {
         let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
         let boundingBox = self.boundingRect(with: constraintRect,
                                             options: .usesLineFragmentOrigin,
                                             attributes: [.font: font],
                                             context: nil)

         return ceil(boundingBox.height)
     }
}
