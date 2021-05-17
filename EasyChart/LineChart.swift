//
//  LineChart.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/11.
//

import UIKit

/// View is to draw `line-chart`
final class LineChart: UIView, ChartProtocol {
    var shapeLayers: ChartShapeLayer
    var property: ChartProperty
    var valueBox: Box = Box()
    var rowBox: Box = Box()
    
    // MARK: - Method
    required init(context: ChartProperty) {
        self.property = context
        self.shapeLayers = ChartShapeLayer(color: context.color)
        super.init(frame: context.frame)
        setUp()
    }

    public override func draw(_ rect: CGRect) {
        drawChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        shapeLayers.defaultLayer.lineWidth = 2
        shapeLayers.defaultLayer.lineCap = .round
        shapeLayers.defaultLayer.lineJoin = .round
      
        layer.addSublayer(shapeLayers.defaultLayer)
        layer.addSublayer(shapeLayers.touchShapeLayer)
        layer.addSublayer(shapeLayers.touchPointShapeLayer)
        
        addTouchGesture()
    }

    // MARK: - Method to draw chart
    /// Draw `line-chart`
    func drawChart() {
        guard let MIN = property.minValue, let MAX = property.maxValue else { return }
        shapeLayers.setLayerColor(property.color)
        let path = UIBezierPath()
        let startCenterY = frame.height-(frame.height*(property.objects[0].value-MIN)/(MAX))
        let width = frame.width/CGFloat(property.objects.count)/2
        var wid = width
        
        path.move(to: CGPoint(x: wid,y: startCenterY))
        
        for i in 0..<property.objects.count {
            let value = frame.height-(frame.height*(property.objects[i].value-MIN)/(MAX))
            path.addLine(to: CGPoint(x: wid, y: value))
            wid += width*2
        }
        
        shapeLayers.defaultLayer.path = path.cgPath
        if property.isAnimated {
            shapeLayers.defaultLayer.add(shapeLayers.animation, forKey: property.key)
        }
    }

    /// Add touch gesture calling `detectTouch(gesture:)`
    private func addTouchGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(detectTouch(gesture:)))
        gesture.minimumPressDuration = 0.2
        addGestureRecognizer(gesture)
    }
    
    /// Detect touch gesture calling `convertGesture(:)`
    /// convertGesture(:) is implemented in `TocuhedChartProtocol`
    @objc private func detectTouch(gesture: UILongPressGestureRecognizer) {
        handleGesture(gesture)
    }
}

// MARK: - Conforming TouchedChartProtocol 
extension LineChart: TouchedChartProtocol {

    /// Draw `circle-point` at each height when touched
    func drawPointWhenTouched(x: CGFloat, idx: Int, wid: CGFloat) {
        guard let MIN = property.minValue , let MAX = property.maxValue else { return }
        let value = frame.height-(frame.height*(property.objects[idx].value-MIN)/(MAX))
        let circle = UIBezierPath(ovalIn: CGRect(x: x-7, y: value-7, width: 14, height: 14))
        shapeLayers.touchPointShapeLayer.path = circle.cgPath
    }
}
