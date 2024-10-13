//
//  HintView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

final class HintView: View {
    var rightSide: Bool = false {
        didSet {
            topHintView.rightSide = rightSide
            bottomHintView.rightSide = rightSide
        }
    }

    var topText: String? {
        didSet {
            topHintView.title = topText
        }
    }

    var bottomText: String? {
        didSet {
            bottomHintView.title = bottomText
        }
    }

    private let topHintView: HintLineView = {
        let view = HintLineView()
        return view
    }()

    private let bottomHintView: HintLineView = {
        let view = HintLineView()
        return view
    }()

    override func setupContent() {
        super.setupContent()
        addSubview(topHintView)
        addSubview(bottomHintView)
    }

    override func setupLayout() {
        super.setupLayout()
        topHintView.leftAnchor ~= leftAnchor
        topHintView.centerXAnchor ~= centerXAnchor
        topHintView.topAnchor ~= topAnchor

        bottomHintView.leftAnchor ~= leftAnchor
        bottomHintView.centerXAnchor ~= centerXAnchor
        bottomHintView.bottomAnchor ~= bottomAnchor

        bottomHintView.topAnchor >= topHintView.bottomAnchor
    }
}

private final class HintLineView: View {
    var title: String? {
        didSet {
            label.text = title
        }
    }

    var rightSide: Bool = false {
        didSet {
            if rightSide {
                stackView.addArrangedSubview(line)
                stackView.addArrangedSubview(label)
            }
            else {
                stackView.addArrangedSubview(label)
                stackView.addArrangedSubview(line)
            }
        }
    }

    private let line: DashLineView = {
        let view = DashLineView()
        return view
    }()

    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Raleway-Regular", size: 12)
        view.textColor = .white.withAlphaComponent(0.5)
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [label, line])
        view.axis = .horizontal
        view.spacing = 2
        return view
    }()

    override func setupContent() {
        super.setupContent()
        addSubview(stackView)
    }

    override func setupLayout() {
        super.setupLayout()
        stackView.pinToSuperview()
    }
}

private final class DashLineView: View {
    private let dashLayer = CAShapeLayer()

    override func setupContent() {
        super.setupContent()

        // Настройка пунктирного слоя
        dashLayer.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor
        dashLayer.lineWidth = 1.0
        dashLayer.lineDashPattern = [2, 2] // Длина штриха и пробела
        layer.addSublayer(dashLayer)
    }

    override func setupLayout() {
        super.setupLayout()
        updatePath()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }

    private func updatePath() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
        dashLayer.path = path.cgPath
        dashLayer.frame = bounds
    }
}
