//
//  DetailsCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

public enum FontText {
    case large
    case create
    case standart
}

public class DetailsCellModel: TableBaseCellModel {

    public var title: String?
    public var attributedText: String?
    public var fontText: FontText?
    public var subtitle: String?
    public var leftIcon: UIImage?
    public var rightIcon: UIImage?
    public var isSelected: Bool = false
    public var isReadOnly: Bool = false
    public var isHiddenSeparatorLine: Bool = true

    override public var cellIdentifier: String {
        return String(describing: DetailsCell.self)
    }

    public init() {
        super.init(action: nil)
    }
}
