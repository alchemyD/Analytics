//
//  QuarterlyViewController.swift
//  DiagnosticTool
//
//  Created by Daniel Dorner on 7/3/16.
//  Copyright © 2016 Daniel Dorner. All rights reserved.
//

import UIKit
import Charts

class QuarterlyViewController: UIViewController {

    
    var analytics = Analytics()
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Animate view
        self.pieChartView.animate(xAxisDuration: 2.0, easingOption: .EaseOutQuad)
        UIView.animateWithDuration(1.5, animations: {
            self.pieChartView.alpha = 1.0
        })
        
        let quarter = ["Q1", "Q2", "Q3", "Q4"]
        setChart(quarter, values: analytics.sales.quarterly)
        
    }
    
    //MARK: Set Pie Chart Data
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = [UIColor.brownColor(), UIColor.orangeColor(), UIColor.blueColor(), UIColor.magentaColor()]
        pieChartDataSet.colors = colors
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
