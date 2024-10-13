//
//  View.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

open class View: UIView {
    open func setupContent() {
        // add subviews
    }

    open func setupLayout() {
        // add constraints
    }

    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupContent()
        subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        setupLayout()
    }
}

