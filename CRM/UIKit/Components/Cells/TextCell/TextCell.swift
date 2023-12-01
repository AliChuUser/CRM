//
//  TextCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

public class TextCell: TableBaseCell {

    @IBOutlet weak var textViewHeight: NSLayoutConstraint!

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "HelveticaNeue", size: 13)
            titleLabel.textColor = Colors.blueyGrey
        }
    }

    @IBOutlet weak var placeholderLabel: UILabel! {
        didSet {
            placeholderLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            placeholderLabel.textColor = Colors.paleLilac
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            let inset: CGFloat = -4
            let defaultInsets = textView.textContainerInset
            textView.textContainerInset = UIEdgeInsets(top: defaultInsets.top, left: inset, bottom: defaultInsets.bottom, right: inset)
            textView.delegate = self
            textView.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
            textView.textColor = Colors.dark
            textView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var separatorLine: UIView! {
        didSet {
            separatorLine.backgroundColor = Colors.separatorLine
        }
    }

    let datePicker = UIDatePicker()

    public override func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? TextCellModel else { return }
        selectionStyle = .none
        titleLabel.text = model.title
        placeholderLabel.text = model.placeholder
        textView.text = model.subtitle
        textView.isUserInteractionEnabled = !model.isReadOnly
        textView.isEditable = true
        switch model.inputType {
        case .text:
            separatorLine.isHidden = model.isHiddenSeparatorLine
        case .date:
            //textView.isEditable = false
            separatorLine.isHidden = false
            let locale = Locale(identifier: "ru")
            datePicker.locale = locale
            textView.inputView = datePicker
            let toolbar = UIToolbar()
            toolbar.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            toolbar.barTintColor = Colors.dodgerBlue
            let attributes = [NSAttributedString.Key.font: UIFont.init(name: "HelveticaNeue", size: 17), NSAttributedString.Key.foregroundColor: Colors.white]
            let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTap))
            cancelButton.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Принять", style: .plain, target: self, action: #selector(doneButtonTap))
            doneButton.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
            toolbar.setItems([cancelButton, spacer, doneButton], animated: false)
            textView.inputAccessoryView = toolbar
            textView.inputView?.backgroundColor = Colors.paleGrey
        case .digits:
            textView.keyboardType = .numberPad
            textView.inputView = nil
            textView.inputAccessoryView = nil
        case .email:
            textView.keyboardType = .emailAddress
            textView.inputView = nil
            textView.inputAccessoryView = nil
        }

        updatePlaceholdeVisibility()
    }
    // MARK: - ToolBar actions

    @objc func cancelButtonTap() {
        endEditing(true)
    }

    @objc func doneButtonTap() {
        guard let model = model as? TextCellModel else { return }
        textView.resignFirstResponder()
        model.onDateChange?(datePicker.date)
    }

    override public func layoutIfNeeded() {
        super.layoutIfNeeded()
        updateTextViewHeightIfNeeded()
    }
}

extension TextCell: UITextViewDelegate {

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let model = self.model as? TextCellModel
        model?.onStartEditing?()
        return true
    }

    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let model = self.model as? TextCellModel
        model?.onEndEditing?()
        return true
    }

    public func textViewDidChange(_ textView: UITextView) {
        updateTextViewHeightIfNeeded()
        let model = self.model as? TextCellModel
        model?.onTextChange?(textView.text)
        updatePlaceholdeVisibility()
    }

    private func updateTextViewHeightIfNeeded() {
        let newHeight = textView.contentSize.height
        if newHeight != textViewHeight.constant {
            textViewHeight.constant = newHeight
        }
    }

    private func updatePlaceholdeVisibility() {
        placeholderLabel.isHidden = textView.text.count > 0
    }

    /// Ограничения на ввод текста в textView
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        /// Запрет перехода на новую строку и скрытие клавиатуры при нажатии на enter
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        /// Проверка начальной позиции курсора
        guard range.location == 0 else {
            return true
        }
        /// Запрет ввода пробела если курсор на начальной позиции
        let newString = (textView.text as NSString).replacingCharacters(in: range, with: text) as NSString
        return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
    }
}
