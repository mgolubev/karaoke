//
//  NavigationView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

final class NavigationView: View {
    enum Action {
        case close
    }
    var actionHandler: (Action) -> Void = { _ in }

    var title: NSAttributedString? {
        didSet {
            titleLabel.attributedText = title
        }
    }

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryBackground
        return view
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        return view
    }()

    private lazy var backButton: UIButton = {
        let view = UIButton()
        view.setImage(
            UIImage(systemName: "chevron.left"),
            for: .normal
        )
        view.tintColor = .primaryAccent
        view.addAction(
            .init(handler: { [weak self] _ in
                self?.actionHandler(.close)
            }),
            for: .touchUpInside
        )
        return view
    }()

    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Raleway-Regular", size: 15)
        view.textColor = .white
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()

    override func setupContent() {
        super.setupContent()
        addSubview(backgroundView)
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(separatorView)
    }

    override func setupLayout() {
        super.setupLayout()
        backgroundView.pinToSuperview(excluding: [.top])
        backgroundView.topAnchor ~= safeAreaLayoutGuide.topAnchor
        backgroundView.heightAnchor ~= 52

        backButton.leftAnchor ~= leftAnchor + 15
        backButton.centerYAnchor ~= backgroundView.centerYAnchor

        titleLabel.centerXAnchor ~= backgroundView.centerXAnchor
        titleLabel.centerYAnchor ~= backgroundView.centerYAnchor
        titleLabel.leftAnchor >= backButton.rightAnchor + 5

        separatorView.pinToSuperview(excluding: [.top])
        separatorView.heightAnchor ~= 1
    }
}
