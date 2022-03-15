//
//  ChartView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit

final class ChartView: UIView {
    private var chartData: [Double] = []
    private var isPositive: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
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
            currencyValues.append(currencyValue - (minValue - (minValue / 5000)))
        }
        
        guard let maxValue = currencyValues.max() else { return }
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        let red: UIColor = .appRedColor ?? .systemRed.withAlphaComponent(0.2)
        let green: UIColor = .appGreenColor ?? .systemGreen.withAlphaComponent(0.2)
        
        let shadowColor: CGColor = (isPositive) ? green.cgColor : red.cgColor
        
        let stepWidth = width / CGFloat(currencyValues.count)
        let multiplier = (height / (maxValue + (maxValue / 500)))
        
        var currentX = 0.0
        var currentY = (height - (currencyValues[0] * multiplier))
        
        for currencyValue in currencyValues {
            let stepHeight = (height-(currencyValue * multiplier))
            
            context.setStrokeColor(shadowColor)
            context.setLineWidth(0.8)
            context.move(to: CGPoint(x: currentX, y: currentY))
            context.addLine(to: CGPoint(x: (currentX + stepWidth), y: stepHeight))
            context.strokePath()
            
            currentX += stepWidth
            currentY = stepHeight
        }
    }
}
