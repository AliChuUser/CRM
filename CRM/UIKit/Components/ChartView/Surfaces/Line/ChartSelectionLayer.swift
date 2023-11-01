//
//  ChartSelectionLayer.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import UIKit

class ChartSelectionLayer: CALayer {

    // MARK: - Public properties

    var text: String? {
        didSet {
            textLayer.string = text
            resetSize()
        }
    }

    var selectionBackgroundCornerRadius: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    var selectionBackgroundColor: UIColor = Colors.black01 {
        didSet {
            backgroundColor = selectionBackgroundColor.cgColor
        }
    }
    var selectionTextColor: UIColor = Colors.white {
        didSet {
            textLayer.foregroundColor = selectionTextColor.cgColor
        }
    }
    var selectionTextFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            textLayer.font = selectionTextFont
            textLayer.fontSize = selectionTextFont.pointSize
        }
    }

    var titleInsets: UIEdgeInsets = .zero

    // MARK: - Private properties

    private lazy var textLayer: CATextLayer = {
        let layer = CATextLayer()
        return layer
    }()

    // MARK: - Lifecycle

    override init() {
        super.init()
        initialSetup()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }

    override func layoutSublayers() {
        textLayer.frame = bounds.inset(by: titleInsets)
        super.layoutSublayers()
    }

    // MARK: - Private methods

    private func initialSetup() {
        backgroundColor = Colors.red01.cgColor
        addSublayer(textLayer)
    }

    private func resetSize() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        let size = textLayer.preferredFrameSize()
        frame.size = CGSize(width: size.width + titleInsets.left + titleInsets.right,
                            height: size.height + titleInsets.top + titleInsets.bottom)
        setNeedsLayout()

        CATransaction.commit()
    }
}
