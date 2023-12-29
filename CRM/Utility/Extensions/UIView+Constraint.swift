//
//  UIView+Constraint.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation
import UIKit

public extension UIView {

    static func deactivate(constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.deactivate(constraints)
    }

    static func activate(constraints: [NSLayoutConstraint]) {
        constraints.forEach { ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    func pin(to view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let anchors = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ]
        UIView.activate(constraints: anchors)
        return anchors
    }

    @discardableResult
    func pin(to view: UIView, insets: UIEdgeInsets = .zero, height: CGFloat) -> [NSLayoutConstraint] {
        let anchors = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            heightAnchor.constraint(equalToConstant: height)
        ]
        UIView.activate(constraints: anchors)
        return anchors
    }

    @discardableResult
    func pin(to view: UIView, top: CGFloat, size: CGSize) -> [NSLayoutConstraint] {
        let anchors = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: UIOffset.zero.horizontal)
        ]
        UIView.activate(constraints: anchors)
        return anchors
    }

    @discardableResult
    func center(in view: UIView, offset: UIOffset = .zero) -> [NSLayoutConstraint] {
        let anchors = [
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.horizontal),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.vertical)
        ]
        UIView.activate(constraints: anchors)
        return anchors
    }

    @discardableResult
    func pin(width: CGFloat) -> NSLayoutConstraint {
        let anchor = widthAnchor.constraint(equalToConstant: width)
        UIView.activate(constraints: [anchor])
        return anchor
    }

    @discardableResult
    func pin(height: CGFloat) -> NSLayoutConstraint {
        let anchor = heightAnchor.constraint(equalToConstant: height)
        UIView.activate(constraints: [anchor])
        return anchor
    }

    @discardableResult
    func pin(to view: UIView, top: CGFloat) -> NSLayoutConstraint {
        let anchor = topAnchor.constraint(equalTo: view.topAnchor, constant: top)
        UIView.activate(constraints: [anchor])
        return anchor
    }

    @discardableResult
    func pin(to view: UIView, bottom: CGFloat) -> NSLayoutConstraint {
        let anchor = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        UIView.activate(constraints: [anchor])
        return anchor
    }

    @discardableResult
    func pin(to view: UIView, right: CGFloat) -> NSLayoutConstraint {
        let anchor = rightAnchor.constraint(equalTo: view.rightAnchor, constant: right)
        UIView.activate(constraints: [anchor])
        return anchor
    }

    @discardableResult
    func pin(to view: UIView, left: CGFloat) -> NSLayoutConstraint {
        let anchor = leftAnchor.constraint(equalTo: view.leftAnchor, constant: left)
        UIView.activate(constraints: [anchor])
        return anchor
    }

    @discardableResult
    func pin(left: UIView, right: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let anchor = left.leftAnchor.constraint(equalTo: right.rightAnchor, constant: constant)
        UIView.activate(constraints: [anchor])
        return anchor
    }
}
