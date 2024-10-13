//
//  SongRangeView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//  Copyright (c) 2024. All rights reserved.
//

import UIKit

/// Root view of SongRange scene
final class SongRangeView: View {
    enum Action {
        case close
        case move(Float)
    }
    var actionHandler: (Action) -> Void = { _ in }

    var viewModel: SongRange.RootViewModel? {
        didSet {
            let nsAttributedString = NSMutableAttributedString(string: "\(viewModel?.author ?? "") - \(viewModel?.song ?? "")")

            let font = UIFont(name: "Raleway-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15)
            let color = UIColor.white.withAlphaComponent(0.5)

            let range = NSRange(location: 0, length: "\(viewModel?.author ?? "") - ".count)

            nsAttributedString.addAttribute(.font, value: font, range: range)
            nsAttributedString.addAttribute(.foregroundColor, value: color, range: range)

            navigationView.title = nsAttributedString

            songSlider.chord = viewModel?.chord
            songSlider.hint = viewModel?.hint
            songHintView.topText = viewModel?.songHint?.top
            songHintView.bottomText = viewModel?.songHint?.bottom
            voiceHintView.topText = viewModel?.voiceHint?.top
            voiceHintView.bottomText = viewModel?.voiceHint?.bottom
        }
    }

    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        return view
    }()

    private let gridView: GridView = {
        let view = GridView()
        return view
    }()

    private lazy var voiceSlider: SliderView = {
        let view = SliderView()
        view.title = "Ваш голос"
        view.heightAnchor ~= 260
        view.widthAnchor ~= 40
        return view
    }()

    private let voiceHintView: HintView = {
        let view = HintView()
        return view
    }()

    private let songHintView: HintView = {
        let view = HintView()
        view.rightSide = true
        return view
    }()

    private lazy var songSlider: SliderView = {
        let view = SliderView()
        view.isEnabled = true
        view.title = "Диапазон песни"
        view.heightAnchor ~= 260
        view.widthAnchor ~= 40
        return view
    }()

    private let songGradientView: GradientView = {
        let view = GradientView()
        view.heightAnchor ~= 540
        view.widthAnchor ~= 40
        return view
    }()

    private lazy var sliderHandler: SliderHandler = {
        let handler = SliderHandler()
        handler.onVerticalDrag = { [weak self] value in
            self?.actionHandler(.move(Float(value)))
        }
        return handler
    }()

    override func setupContent() {
        super.setupContent()
        addSubview(gridView)
        addSubview(songGradientView)
        addSubview(songHintView)
        addSubview(voiceHintView)
        addSubview(voiceSlider)
        addSubview(songSlider)
        addSubview(navigationView)

        backgroundColor = .primaryBackground
        sliderHandler.sourceView = songSlider
    }

    override func setupLayout() {
        super.setupLayout()
        navigationView.pinToSuperview(excluding: [.bottom])
        gridView.topAnchor ~= navigationView.bottomAnchor + 16
        gridView.widthAnchor ~= 281
        gridView.centerXAnchor ~= centerXAnchor
        gridView.bottomAnchor ~= safeAreaLayoutGuide.bottomAnchor - 16

        voiceSlider.leftAnchor ~= gridView.leftAnchor + 60
        voiceSlider.topAnchor ~= gridView.topAnchor + 60

        voiceHintView.leftAnchor ~= leftAnchor + 19
        voiceHintView.topAnchor ~= voiceSlider.topAnchor
        voiceHintView.bottomAnchor ~= voiceSlider.bottomAnchor
        voiceHintView.rightAnchor ~= voiceSlider.leftAnchor - 9

        songHintView.rightAnchor ~= rightAnchor - 19
        songHintView.topAnchor ~= songSlider.topAnchor
        songHintView.bottomAnchor ~= songSlider.bottomAnchor
        songHintView.leftAnchor ~= songSlider.rightAnchor + 9

        songSlider.leftAnchor ~= gridView.leftAnchor + 180
        songSlider.topAnchor ~= gridView.topAnchor + 140

        songGradientView.leftAnchor ~= gridView.leftAnchor + 180
        songGradientView.topAnchor ~= gridView.topAnchor
    }
}

private class SliderHandler {
    var onVerticalDrag: ((CGFloat) -> Void)?
    weak var sourceView: UIView? {
        didSet {
            guard let sourceView else {
                oldValue?.removeGestureRecognizer(gestureRecognizer)
                return
            }
            sourceView.isUserInteractionEnabled = true
            sourceView.addGestureRecognizer(gestureRecognizer)
        }
    }

    private var initialTouchPoint: CGPoint?
    private lazy var gestureRecognizer: UIGestureRecognizer = {
        UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    }()

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let sourceView else { return }
        let touchPoint = gesture.location(in: sourceView)

        switch gesture.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            guard let initialPoint = initialTouchPoint else { return }
            let verticalOffset = initialPoint.y - touchPoint.y
            let offsetCoefficient = verticalOffset / sourceView.bounds.height
            onVerticalDrag?(offsetCoefficient)
        case .ended, .cancelled:
            initialTouchPoint = nil
        default:
            break
        }
    }
}
