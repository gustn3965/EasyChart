//
//  LineChart.swift
//  EasyChart
//
//  Created by hyunsu on 2021/05/11.
//

import UIKit

/// View is to draw `line-chart`
final class BarChart: UIView, ChartProtocol {
    var shapeLayers: ChartShapeLayer
    var property: ChartProperty
    var valueBox: Box = Box()
    var rowBox: Box = Box()
    
    // MARK: - Method
    required init(context: ChartProperty) {
        self.property = context
        self.shapeLayers = ChartShapeLayer(color: context.color)
        super.init(frame: context.frame)
        clipsToBounds = true
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        if property.isShowingImmediately {
            drawChart()
        }
    }

    private func setUp() {
        shapeLayers.defaultLayer.lineCap = .square
        shapeLayers.defaultLayer.lineJoin = .bevel
      
        layer.addSublayer(shapeLayers.defaultLayer)
        layer.addSublayer(shapeLayers.touchShapeLayer)
        layer.addSublayer(shapeLayers.touchPointShapeLayer)
        
        addTouchDelegate()
    }

    // MARK: - Method to draw chart
    /// Draw `line-chart`
    func drawChart() {
        guard let MIN = property.minValue, let MAX = property.maxValue else { return }
        shapeLayers.setLayerColor(property.color)
        let path = UIBezierPath()
        let width = frame.width/CGFloat(property.objects.count)/2
        var wid = width

        for i in 0..<property.objects.count {
            path.move(to: CGPoint(x: wid, y: frame.height))
            let value = frame.height-(frame.height*(property.objects[i].value-MIN)/(MAX))
            if value < frame.height {
                path.addLine(to: CGPoint(x: wid, y: value))
            }
            wid += width*2
        }
        shapeLayers.defaultLayer.lineWidth = width
        shapeLayers.defaultLayer.path = path.cgPath
        shapeLayers.defaultLayer.add(shapeLayers.animation, forKey: property.key)
    }
    
    /// Add touch gesture calling `detectTouch(gesture:)`
    private func addTouchDelegate() {
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
extension BarChart: TouchedChartProtocol {

    /// Draw `rectangle-point` at each height when touched
    func drawPointWhenTouched(x: CGFloat, idx: Int, wid: CGFloat) {
        guard let MIN = property.minValue , let MAX = property.maxValue else { return }
        let value = frame.height-(frame.height*(property.objects[idx].value-MIN)/(MAX))
        let square = UIBezierPath(rect: CGRect(x: x-wid/2, y: value-wid/2, width: wid, height: wid))

        shapeLayers.touchPointShapeLayer.path = square.cgPath
    }
}
