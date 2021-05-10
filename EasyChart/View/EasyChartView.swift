//
//  ChartView.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.


import UIKit


/// chartView와 데이터의 값을 나타내는 2개의 Label을 갖는 View
final public class EasyChartView: UIView {
    
    public var chartView: DrawingView
    private var stackView:  UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    public var valueLabel = UILabel()
    public var rowLabel = UILabel()
    
    // MARK: - init Method
    /// Drawing 초기화하는 메서드
    /// - Parameters:
    ///   - frame: CGRect
    ///   - objects: 차트를 표현하기 위한 데이터 배열( EasyChartObjectProtocol을 채택해야한다 )
    ///   - showImmediately: 초기화하고 바로 나타날지 결정
    ///   - color: 차트색을 나타내는 객체
    public init(frame: CGRect = .zero,
                objects: [EasyChartObjectProtocol],
                showImmediately: Bool = true,
                color: EasyChartColor = EasyChartColor(chartColor: #colorLiteral(red: 0.83, green: 0.25, blue: 0.00, alpha: 1.00),
                                                       touchedChartColor: #colorLiteral(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00))) {
        chartView = DrawingView(objects: objects)
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
