//
//  ChartView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit

final class ChartView: UIView {
    private var chartData: [Double] = []
    private let background: UIColor
    private let strokeColor: UIColor
    private var isPositive: Bool = false
    
    init(background: UIColor = .white, strokeColor: UIColor = .darkGray) {
        self.background = background
        self.strokeColor = strokeColor
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = background
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fillChartWith(data: [Double], isPositive: Bool) {
        self.chartData = data
        self.isPositive = isPositive
        draw(CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(),
              let minValue = chartData.min() else { return }
        
        
        var currencyValues = [Double]()
        for currencyValue in chartData {
            currencyValues.append(currencyValue - (minValue - (minValue / 75)))
        }
        
        guard let maxValue = currencyValues.max() else { return }
        
        let red: UIColor = .appRedColor ?? .systemRed.withAlphaComponent(0.5)
        let green: UIColor = .appGreenColor ?? .systemGreen.withAlphaComponent(0.5)
        
        let shadowColor: CGColor = (isPositive) ? green.cgColor : red.cgColor
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let stepWidth = width / CGFloat(currencyValues.count)
        let multiplier = (height / (maxValue + (maxValue / 20)))
        
        var currentX = 0.0
        var currentY = (height - (currencyValues[0] * multiplier))
        
        for currencyValue in currencyValues {
            let stepHeight = (height-(currencyValue * multiplier))
            
            context.setStrokeColor(UIColor.darkGray.cgColor)
            context.setLineWidth(0.5)
            context.move(to: CGPoint(x: currentX, y: currentY))
            context.addLine(to: CGPoint(x: (currentX + stepWidth), y: stepHeight))
            context.setShadow(offset: CGSize(width: 1, height: 0), blur: 1.0, color: shadowColor)
            context.strokePath()
            
            currentX += stepWidth
            currentY = stepHeight
        }
    }
}
