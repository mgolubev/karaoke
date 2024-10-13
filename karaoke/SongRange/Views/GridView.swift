//
//  GridView.swift
//  karaoke
//
//  Created by Michael Golubev on 13.10.2024.
//

import UIKit

final class GridView: UIView {
    private let gridLayer = CALayer()
    private let lineColor: UIColor = .darkGray.withAlphaComponent(0.5)
    private let gridSize: CGFloat = 20.0
    private let fadeLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }

    private func setupLayer() {
        // Добавляем слой сетки к представлению
        self.layer.addSublayer(gridLayer)
        gridLayer.frame = self.bounds
        drawGrid()

        // Добавляем градиентный слой для плавного исчезновения сверху и снизу
        fadeLayer.colors = [
            UIColor.clear.cgColor,
            lineColor.cgColor,
            lineColor.cgColor,
            UIColor.clear.cgColor
        ]
        fadeLayer.locations = [0.0, 0.1, 0.9, 1.0]
        fadeLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        fadeLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        fadeLayer.frame = self.bounds
        self.layer.addSublayer(fadeLayer)
        fadeLayer.mask = gridLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gridLayer.frame = self.bounds
        fadeLayer.frame = self.bounds
        drawGrid()
    }

    private func drawGrid() {
        // Очистить предыдущие подслои
        gridLayer.sublayers?.forEach { $0.removeFromSuperlayer() }

        // Вертикальные линии
        for x in stride(from: 0, to: bounds.width, by: gridSize) {
            let lineLayer = createLineLayer()
            lineLayer.path = UIBezierPath(rect: CGRect(x: x, y: 0, width: 0.5, height: bounds.height)).cgPath
            gridLayer.addSublayer(lineLayer)
        }

        // Горизонтальные линии
        for y in stride(from: 0, to: bounds.height, by: gridSize) {
            let lineLayer = createLineLayer()
            lineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: y, width: bounds.width, height: 0.5)).cgPath
            gridLayer.addSublayer(lineLayer)
        }
    }

    private func createLineLayer() -> CAShapeLayer {
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.lineWidth = 1.0
        lineLayer.lineDashPattern = [2, 2] // Делаем линию пунктирной
        lineLayer.fillColor = UIColor.clear.cgColor
        return lineLayer
    }
}
