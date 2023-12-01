//
//  TableFooter.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

open class TableFooter: UIView {

    @IBOutlet var container: UIView!
    @IBOutlet weak var button: UIButton!


    override public var intrinsicContentSize: CGSize {
        var superSize = super.intrinsicContentSize
        superSize.height = container.intrinsicContentSize.height
        return superSize
    }

    public var onTapButton: (() -> Void)?
    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle(for: TableFooter.self).loadNibNamed("TableFooter", owner: self, options: nil)
        addSubview(container)
        container.backgroundColor = .red
        button.backgroundColor = Colors.black
    }
    @IBAction func tapButton(_ sender: UIButton) {
        onTapButton?()
    }
}
