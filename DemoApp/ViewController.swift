//
//  ViewController.swift
//  DemoApp
//
//  Created by hyunsu on 2021/05/10.
//

import UIKit
import EasyChart
class ViewController: UIViewController {
    
    var easyChartView: EasyChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = [(0,"7/01"),(30,"7/02"),(5,"7/03"),(50,"7/04"),(35,"7/05"),(5,"7/06"),(80,"7/07"),(150,"7/08"),(120,"7/09"),(95,"7/10"),(0,"7/11"),(30,"7/12"),(210,"7/13"),(70,"7/14"),(35,"7/15"),(230,"7/16"),(135,"7/17"),(150,"7/18"),(300,"7/19"),(95,"7/20")].map{Object(value: $0.0, row: $0.1)}
        
        easyChartView = EasyChartView(objects: data, showImmediately: false)
        view.addSubview(easyChartView)
        easyChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [   easyChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                easyChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
                easyChartView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
                easyChartView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    @IBAction func clickButton() {
        easyChartView.chartView.drawBarChart()
    }
}

