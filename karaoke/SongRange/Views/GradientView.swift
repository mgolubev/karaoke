//
//  GradientView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

final class GradientView: View {

    private let gradientLayer = CAGradientLayer()

    override func setupContent() {
        super.setupContent()

        // Настройка градиентного слоя
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.primaryAccent.withAlphaComponent(0.15).cgColor,
            UIColor.primaryAccent.withAlphaComponent(0.15).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.addSublayer(gradientLayer)
    }

    override func setupLayout() {
        super.setupLayout()
        gradientLayer.frame = bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
