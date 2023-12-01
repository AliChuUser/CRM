//
//  TextCellModel.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation

public enum InputType {
    case text
    case digits
    case date
    case email
}
public class TextCellModel: TableBaseCellModel {

    public var title: String?
    public var placeholder: String?
    public var subtitle: String?
    public var inputType: InputType = .text
    public var isReadOnly: Bool = false
    public var isHiddenSeparatorLine: Bool = false

    public var onTextChange: ((String) -> Void)?
    public var onDateChange: ((Date) -> Void)?

    public var onStartEditing: (() -> Void)?
    public var onEndEditing: (() -> Void)?

    public override var cellIdentifier: String {
        return String(describing: TextCell.self)
    }

    public init() {
        super.init(action: nil)
    }
}
