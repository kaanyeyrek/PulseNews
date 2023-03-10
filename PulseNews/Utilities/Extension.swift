//
//  Extension.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/3/23.
//

import UIKit

private var emptyView: EmptyView?

// Duplicate Array Ex
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var results = [Element]()
        for value in self {
            if !results.contains(value) {
                results.append(value)
            } else {
                print("duplicate")
            }
        }
        return results
    }
}
// NSLayout Ex
struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
extension UIView {
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        if let leading = leading {
            anchoredConstraints.top = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        let anchorArray = [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height]
        anchorArray.forEach({
            $0?.isActive = true
        })
        return anchoredConstraints
    }
    func fillSuperView(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        if let superViewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superViewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        if let superViewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superViewLeadingAnchor, constant: padding.left).isActive = true
        }
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    func centerInSuperView(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
// Custom alert ex
extension UIViewController {
  func alert(message: String, title: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
  }
// Empty View
    func showEmptyStateView(with message: String, at view: UIView) {
        DispatchQueue.main.async {
            emptyView?.removeFromSuperview()
            emptyView = EmptyView(message: message)
            guard let emptyView = emptyView else { return }
            emptyView.frame = view.safeAreaLayoutGuide.layoutFrame
            view.addSubview(emptyView)
        }
    }
    func removeEmptyStateView() {
        DispatchQueue.main.async {
            emptyView?.removeFromSuperview()
        }
    }
}
