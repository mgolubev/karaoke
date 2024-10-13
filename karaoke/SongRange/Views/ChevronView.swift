//
//  ChevronView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

final class ChevronView: View {
    var hint: String? {
        didSet {
            hintLabel.text = hint
            hintLabel.isHidden = hint?.isEmpty != false
        }
    }

    var up: Bool = false {
        didSet {
            updateView()
        }
    }

    private let hintLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Raleway-Regular", size: 10)
        view.textColor = .primaryAccent
        view.textAlignment = .center
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        return view
    }()

    override func setupContent() {
        super.setupContent()
        addSubview(stackView)

        updateView()
    }

    override func setupLayout() {
        super.setupLayout()
        stackView.pinToSuperview(top: 6, bottom: 6)
    }

    private func updateView() {
        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        var array: [UIView] = []

        for i in 1...3 {
            let view = UIImageView(image: UIImage(systemName: up ? "chevron.up" : "chevron.down"))
            view.contentMode = .center
            view.heightAnchor ~= 13
            view.tintColor = .primaryAccent.withAlphaComponent(CGFloat(i) * 0.15)
            if up {
                array.append(view)
            }
            else {
                array.insert(view, at: 0)
            }
        }

        if up {
            array.append(hintLabel)
        }
        else {
            array.insert(hintLabel, at: 0)
        }

        array.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
}
