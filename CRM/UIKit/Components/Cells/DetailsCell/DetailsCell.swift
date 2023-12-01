//
//  DetailsCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

public class DetailsCell: TableBaseCell {

    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var rightIconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.init(name: "HelveticaNeue-Medium", size: 17)
            titleLabel.textColor = Colors.dark
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel!

    @IBOutlet weak var titleLeadingImage: NSLayoutConstraint!
    @IBOutlet weak var titleLeadingView: NSLayoutConstraint!

    @IBOutlet weak var titleBottomView: NSLayoutConstraint!
    @IBOutlet weak var titleBottomSubtitle: NSLayoutConstraint!

    @IBOutlet weak var separatorLine: UIView! {
        didSet {
            separatorLine.backgroundColor = Colors.separatorLine
        }
    }

    override public func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? DetailsCellModel else { return }
        selectionStyle = .none
        if let attributedText = model.attributedText {
            var attributes = [NSAttributedString.Key: Any]()
            switch model.fontText {
            case .large:
                attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 28) as Any]
            case .create:
                attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 13) as Any, NSAttributedString.Key.foregroundColor: Colors.blueyGrey]
            case .standart:
                attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 17) as Any, NSAttributedString.Key.foregroundColor: Colors.dark]
            case .none:
                break
            }
            titleLabel.attributedText = NSAttributedString(string: attributedText, attributes: attributes as [NSAttributedString.Key : Any])
        } else {
            // Обычные ячейки в пуллерах
            titleLabel.text = model.title
        }

        if model.isReadOnly {
            separatorLine.isHidden = true
            isUserInteractionEnabled = !model.isReadOnly
        }

        if let leftImage = model.leftIcon {
            leftIconImageView.image = leftImage
            titleLeadingView.priority = .defaultLow
            titleLeadingImage.priority = .defaultHigh
        } else {
            leftIconImageView.image = nil
            titleLeadingView.priority = .defaultHigh
            titleLeadingImage.priority = .defaultLow
        }

        if let rightImage = model.rightIcon {
            rightIconImageView.image = rightImage
        }

        if let subtitle = model.subtitle {
            switch model.fontText {
            case .large:
                break
            case .create:
                subtitleLabel.font = UIFont.init(name: "HelveticaNeue-Medium", size: 17)
                subtitleLabel.textColor = Colors.dark
            case .standart:
                subtitleLabel.font = UIFont.init(name: "HelveticaNeue", size: 13)
                subtitleLabel.textColor = Colors.blueyGrey
            case .none:
                break
            }
            subtitleLabel.text = subtitle
            titleBottomView.priority = .defaultLow
            titleBottomSubtitle.priority = .defaultHigh
        } else {
            subtitleLabel.text = nil
            titleBottomView.priority = .defaultHigh
            titleBottomSubtitle.priority = .defaultLow
        }
    }
}
