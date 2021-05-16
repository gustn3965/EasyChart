//
//  ViewController.swift
//  DemoApp
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit
import EasyChart
class ViewController: UIViewController {
    
    var easyLineChartView: EasyChartView!
    var easyBarChartView: EasyChartView!
    @IBOutlet weak var button: UIButton!
    
    let data = [(0,"7/01"),(30,"7/02"),(5,"7/03"),(50,"7/04"),(35,"7/05"),(20,"7/06"),(80,"7/07"),(95,"7/08"),(65,"7/09"),(30,"7/10"),(43,"7/11"),(230,"7/12"),(110,"7/13"),(75,"7/14"),(80,"7/15"),(150,"7/16"),(0,"7/01"),(30,"7/02"),(5,"7/03"),(50,"7/04"),(35,"7/05"),(20,"7/06"),(80,"7/07"),(95,"7/08"),(65,"7/09"),(30,"7/10"),(43,"7/11"),(230,"7/12"),(110,"7/13"),(75,"7/14"),(80,"7/15"),(150,"7/16")].map{Object(value: $0.0, row: $0.1)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLineChartViewWithConstraint()
        setBarChartViewWithConstraint()
        printSwift()
        
    }
    func printSwift() {
        #if swift(>=5.4)
            print("5.4")
        #elseif swift(>=5.3)
           print("not 5.3")
        #endif
    }
    
    func setLineChartViewWithConstraint() {
        easyLineChartView = EasyChartView(objects: data, showImmediately: true)
        view.addSubview(easyLineChartView)
        easyLineChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [   easyLineChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                easyLineChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
                easyLineChartView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
                easyLineChartView.bottomAnchor.constraint(equalTo: button.topAnchor,constant: -10)
            ])
    }
    
    func setBarChartViewWithConstraint() {
        easyBarChartView = EasyChartView(chart: .barChart, objects: data, showImmediately: true)
        view.addSubview(easyBarChartView)
        easyBarChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [   easyBarChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                easyBarChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
                easyBarChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
                easyBarChartView.topAnchor.constraint(equalTo: button.bottomAnchor,constant: 50)
            ])
    }
    
    @IBAction func clickButton() {
        easyBarChartView.drawChart()
        easyLineChartView.drawChart()
    }
}

