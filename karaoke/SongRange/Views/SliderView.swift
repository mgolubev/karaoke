//
//  SliderView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

final class SliderView: View {

    var isEnabled: Bool = false {
        didSet {
            layer.borderWidth = isEnabled ? 1 : 0
            topChevron.isHidden = !isEnabled
            bottomChevron.isHidden = !isEnabled
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var chord: String? {
        didSet {
            chordLabel.text = chord
        }
    }

    var hint: String? {
        didSet {
            topChevron.hint = hint
        }
    }

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Raleway-Regular", size: 12)
        view.textColor = .white.withAlphaComponent(0.8)
        return view
    }()

    private let chordLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Raleway-Regular", size: 10)
        view.textColor = .primaryAccent
        return view
    }()

    private let topChevron: ChevronView = {
        let view = ChevronView()
        view.up = true
        view.isHidden = true
        return view
    }()

    private let bottomChevron: ChevronView = {
        let view = ChevronView()
        view.up = false
        view.isHidden = true
        return view
    }()

    override func setupContent() {
        super.setupContent()
        backgroundColor = .primaryAccent.withAlphaComponent(0.25)
        layer.cornerRadius = 8
        layer.borderColor = UIColor.primaryAccent.cgColor
        addSubview(titleLabel)
        addSubview(chordLabel)
        addSubview(topChevron)
        addSubview(bottomChevron)
    }

    override func setupLayout() {
        super.setupLayout()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor ~= centerXAnchor
        titleLabel.centerYAnchor ~= centerYAnchor
        titleLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

        chordLabel.topAnchor ~= topAnchor + 8
        chordLabel.centerXAnchor ~= centerXAnchor

        topChevron.leftAnchor ~= leftAnchor
        topChevron.centerXAnchor ~= centerXAnchor
        topChevron.bottomAnchor ~= topAnchor

        bottomChevron.leftAnchor ~= leftAnchor
        bottomChevron.centerXAnchor ~= centerXAnchor
        bottomChevron.topAnchor ~= bottomAnchor
    }
}
