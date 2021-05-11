//
//  DrawingView.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit


/// 기본차트와 터치했을때 부각시키는 Layer를 그려주는 객체
/// - 초기화한후, 다시 차트를 그려주고 싶을때는 drawChart() 메서드를 이용하면 됩니다.
final public class DrawingView: UIView {
    private let key = "strokeEnd"

    private let shapeLayer = CAShapeLayer()
    private var touchShapeLayer = CAShapeLayer()
    private var touchCircleShapeLayer = CAShapeLayer()
        
    private let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue=1
        animation.duration = 0.7
        return animation
    }()

    public var objects: [EasyChartObjectProtocol] = [] {
        didSet { caculateMinMax(objects) }
    }

    private var minValue: CGFloat?
    private var maxValue: CGFloat?
    
    public var isShowingImmediately = true
    public var color: EasyChartColor
    
    var valueBox: Box = Box()
    var rowBox: Box = Box()
    
    // MARK: - init method
    
    /// Drawing 초기화하는 메서드
    /// - Parameters:
    ///   - objects: 차트를 표현하기 위한 데이터 배열
    ///   - showImmediately: 초기화하고 바로 나타날지 결정
    ///   - color: 차트색을 나타내는 객체
    public init(objects: [EasyChartObjectProtocol],
                showImmediately: Bool = true,
                color: EasyChartColor = EasyChartColor(chartColor: #colorLiteral(red: 0.83, green: 0.25, blue: 0.00, alpha: 1.00),
                                                       touchedChartColor: #colorLiteral(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00))) {
        self.objects = objects
        self.isShowingImmediately = showImmediately
        self.color = color
        super.init(frame: CGRect.zero)
        caculateMinMax(objects)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        if isShowingImmediately {
            drawChart()
        }
    }

    private func setUp() {
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.strokeColor = color.chartColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        touchShapeLayer.strokeColor = color.touchedChartColor.cgColor
        touchCircleShapeLayer.fillColor = color.touchedChartColor.cgColor
        layer.addSublayer(shapeLayer)
        layer.addSublayer(touchShapeLayer)
        layer.addSublayer(touchCircleShapeLayer)
        
        addTouchDelegate()
    }
    
    private func caculateMinMax(_ objects: [EasyChartObjectProtocol]) {
        minValue = objects.min(by: {$0.value<$1.value})?.value
        maxValue = objects.max(by: {$0.value<$1.value})?.value
    }
    
    // MARK: - Chart 그려주는 메서드
    
    
    public func drawBarChart() {
        guard let MIN = minValue, let MAX = maxValue else { return }
        let path = UIBezierPath()
        let width = frame.width/CGFloat(objects.count)/2

        var wid = width
        let lineWidth = wid
        for i in 0..<objects.count {
            path.move(to: CGPoint(x: wid, y: frame.height))
            let value = frame.height-(frame.height*(objects[i].value-MIN)/(MAX))
            path.addLine(to: CGPoint(x: wid, y: value))
            wid += width*2
        }
        shapeLayer.lineWidth = lineWidth
        shapeLayer.add(animation, forKey: key)
    }
    
    /// Chart 그려주는 메서드
    public func drawChart() {
        guard let MIN = minValue, let MAX = maxValue else { return }
        let path = UIBezierPath()
        let startCenterY = frame.height-(frame.height*(objects[0].value-MIN)/(MAX))
        let width = frame.width/CGFloat(objects.count-1)
        var wid = CGFloat(0)
        
        path.move(to: CGPoint(x: 0,y: startCenterY))
        
        for i in 0..<objects.count {
            let value = frame.height-(frame.height*(objects[i].value-MIN)/(MAX))
            path.addLine(to: CGPoint(x: wid, y: value))
            wid += width
        }
        
        shapeLayer.path = path.cgPath
        shapeLayer.add(animation, forKey: key)
    }

    private func addTouchDelegate() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(detectTouch(gesture:)))
        gesture.minimumPressDuration = 0.2
        addGestureRecognizer(gesture)
    }
    

    @objc private func detectTouch(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            shapeLayer.strokeColor = color.touchedChartColor.cgColor
        case .ended:
            shapeLayer.strokeColor = color.chartColor.cgColor
            touchShapeLayer.path = nil
            touchCircleShapeLayer.path = nil
            valueBox.value = nil
            rowBox.value = nil
        default:
            drawLineCircle(gesture: gesture)
        }
    }
    
    // MARK: - Touch했을때 부각시키기위해 Line, Circle 그려주는 메서드
    private func drawLineCircle(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self)
        let width = frame.width/CGFloat(objects.count-1)
        
        var wid = CGFloat(0)
        for i in 0..<objects.count {
            let left = wid - width/2 >= 0 ? wid-width/2 : 0
            let right = wid + width/2 <= frame.width ? wid+width/2 : frame.width
            
            if (left...right).contains(location.x) {
                drawLine(x: wid)
                drawCircle(x: wid, idx: i)
                valueBox.value = String(Float(objects[i].value))
                rowBox.value = objects[i].row
            }
            wid+=width
        }
    }
    
    private func drawLine(x: CGFloat ) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: x, y: 0))
        linePath.addLine(to: CGPoint(x: x, y: frame.height))
        touchShapeLayer.path = linePath.cgPath
    }

    private func drawCircle(x:CGFloat, idx: Int) {
        guard let MIN = minValue , let MAX = maxValue else { return }
        let value = frame.height-(frame.height*(objects[idx].value-MIN)/(MAX))
        let circle = UIBezierPath(ovalIn: CGRect(x: x-7, y: value-7, width: 14, height: 14))
        touchCircleShapeLayer.path = circle.cgPath
    }
}
