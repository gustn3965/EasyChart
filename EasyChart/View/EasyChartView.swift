//
//  ChartView.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.


import UIKit


/// chartView와 데이터의 값을 나타내기 위한 2개의 Label을 갖는 View
/// - chartView: 차트뷰
/// - valueLabel: 뷰좌측상단에 나타나는 label
/// - rowLabel: 뷰우측상단에 나타나는 label
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
    /// Drawing 초기화하는 메서드
    /// - Parameters:
    ///   - frame: CGRect
    ///   - objects: 차트를 표현하기 위한 데이터 배열( EasyChartObjectProtocol을 채택해야한다 )
    ///   - showImmediately: 초기화하고 바로 나타날지 결정
    ///   - color: 차트색을 나타내는 객체
    public init(frame: CGRect = .zero,
                chart: FactoryChart = .lineChart,
                objects: [EasyChartObjectProtocol],
                showImmediately: Bool = true,
                color: EasyChartColor = EasyChartColor(chartColor: #colorLiteral(red: 0.83, green: 0.25, blue: 0.00, alpha: 1.00),
                                                       touchedChartColor: #colorLiteral(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00))) {
        let context = ChartProperty(frame: frame, objects: objects, isShowingImmediately: showImmediately, color: color)
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

// MARK: - Convenient 메소드 및 프로퍼티
extension EasyChartView {

    /// 차트 타입에 따라 차트 그려준다.
    public func drawChart() {
        chartView.drawChart()
    }
    
    /// 차트 데이터 - get set
    public var objects: [EasyChartObjectProtocol] {
        get {
            return chartView.property.objects
        }
        set {
            chartView.property.objects = newValue
        }
    }
    
    /// 기본차트 색 - get set
    public var chartColor: UIColor {
        get {
            return chartView.property.color.chartColor
        }
        set {
            return chartView.property.color.chartColor = newValue
        }
    }
    
    /// 터치된 차트 색 - get set
    public var touchedChartColor: UIColor {
        get {
            return chartView.property.color.touchedChartColor
        }
        set {
            return chartView.property.color.touchedChartColor = newValue
        }
    }
}
