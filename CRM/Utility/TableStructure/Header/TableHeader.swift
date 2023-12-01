//
//  TableHeader.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

open class TableHeader: UIView {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        }
    }
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.layer.borderWidth = 1
            searchBar.layer.borderColor = UIColor.white.cgColor
        }
    }

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public var buttonImage: UIImage? {
        didSet {
            button.setImage(buttonImage, for: .normal)
        }
    }

    public var onTapButton: (() -> Void)?

    override public var intrinsicContentSize: CGSize {
        var superSize = super.intrinsicContentSize
        superSize.height = container.intrinsicContentSize.height
        return superSize
    }

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
        Bundle(for: TableHeader.self).loadNibNamed("TableHeader", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func tapButton(_ sender: UIButton) {
        onTapButton?()
    }
}
