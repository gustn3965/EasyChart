//
//  ChartView.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.


import UIKit

/// View that has `chartView` and `2 labels` to show value and row
/// - chartView:  chart
/// - valueLabel: label to show value in `top left`
/// - rowLabel: label to show row in `top right.
final public class EasyChartView: UIView {
    
    var chartView: ChartProtocol
    private var stackView:  UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    public var valueLabel = UILabel()
    public var rowLabel = UILabel()
    
    // MARK: - init Method
    /// - Parameters:
    ///   - frame: CGRect
    ///   - chart: One of chart - `.lineChart` or `.barChart`
    ///   - objects: Data to be represented by chart ( should be conforming `EasyChartObjectProtocol` )
    ///   - isAnimated: Whether to be showe chart being animated
    ///   - color: colors to be applied in chart color
    public init(frame: CGRect = .zero,
                chart: FactoryChart = .lineChart,
                objects: [EasyChartObjectProtocol],
                isAnimated: Bool = true,
                color: EasyChartColor = EasyChartColor(chartColor: #colorLiteral(red: 0.83, green: 0.25, blue: 0.00, alpha: 1.00),
                                                       touchedChartColor: #colorLiteral(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00))) {
        let context = ChartProperty(frame: frame, objects: objects, isAnimated: isAnimated, color: color)
        chartView = chart.initChartViewBy(context)
        
        super.init(frame: frame)
        setUI()
        addConstraint()
        addObserver()
    }

    private func setUI() {
        let horizonStack = UIStackView(arrangedSubviews: [valueLabel,rowLabel])
        horizonStack.distribution = .fillEqually
        horizonStack.spacing = 10
        horizonStack.axis = .horizontal
        stackView.addArrangedSubview(horizonStack)
        stackView.addArrangedSubview(chartView)
        valueLabel.textColor = .clear
        valueLabel.textAlignment = .right
        rowLabel.textColor = .clear
        rowLabel.textAlignment = .left
        valueLabel.text = " "
        rowLabel.text = " "
        addSubview(stackView)
    }
    
    private func addConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
             stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
             stackView.topAnchor.constraint(equalTo: topAnchor),
             stackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func addObserver() {
        chartView.valueBox.addObserver(observer: { [weak self] valueTitle in
            guard let title = valueTitle else {
                self?.valueLabel.textColor = .clear
                return
            }
            self?.valueLabel.text = title
            self?.valueLabel.textColor = .black
        })

        chartView.rowBox.addObserver(observer: { [weak self] rowTitle in
            guard let row = rowTitle else {
                self?.rowLabel.textColor = .clear
                return
            }
            self?.rowLabel.text = row
            self?.rowLabel.textColor = .black
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Conveninet method and properties
extension EasyChartView {

    /// Data objests to be presented in chart.
    public var objects: [EasyChartObjectProtocol] {
        get {
            return chartView.property.objects
        }
        set {
            chartView.property.objects = newValue
            chartView.setNeedsDisplay()
        }
    }
    
    /// Normal chart color
    public var chartColor: UIColor {
        get {
            return chartView.property.color.chartColor
        }
        set {
            chartView.property.color.chartColor = newValue
            chartView.setNeedsDisplay()
        }
    }
    
    /// Touched chart color
    public var touchedChartColor: UIColor {
        get {
            return chartView.property.color.touchedChartColor
        }
        set {
            chartView.property.color.touchedChartColor = newValue
            chartView.setNeedsDisplay()
        }
    }
    
    /// Determine chartview being animated
    public var isAnimated: Bool {
        get {
            return chartView.property.isAnimated
        }
        set {
            chartView.property.isAnimated = newValue
            chartView.setNeedsDisplay()
        }
    }
    
    /// Draw again chart view
    public func drawChart() {
        chartView.setNeedsDisplay()
    }
}
