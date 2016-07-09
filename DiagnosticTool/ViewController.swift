
//
//  ViewController.swift
//  DiagnosticTool
//
//  Created by Dan Dorner on 6/3/16.
//  Copyright © 2016 Daniel Dorner. All rights reserved.
//

import UIKit
import Charts
import Alamofire


class ViewController: UIViewController, UITableViewDelegate{
    
    //MARK: Declaring Variables
    var analytics = Analytics()
    
    
    
    //MARK: Outlets
   // @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var salesTodayOutlet: UILabel!
    @IBOutlet weak var salesYesterdayOutlet: UILabel!
    @IBOutlet weak var percentChangedOutlet: UILabel!
    @IBOutlet weak var salesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BaseAnalytics.init(jsonPath: "SalesData")
        
        
        let days = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"]
        setChart(days, values: analytics.sales.daily)
        
        // Set bar chart data to previously created data
        salesView.alpha = 0
        
        //Update labels
        salesTodayOutlet.text = "$\(String(analytics.sales.today))"
        salesYesterdayOutlet.text = "$\(String(analytics.sales.yesterday))"
        percentChangedOutlet.text = "\(String(analytics.sales.percentChangeToday))%"
        
        //Calculate and display precentage change
        var change:Double? = analytics.sales.percentChangeToday
        if(change > 0){
            percentChangedOutlet.textColor = UIColor.greenColor()
        }else{
            percentChangedOutlet.textColor = UIColor.redColor()
        }
        
    }
    
    //MARK: Set Chart Data
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartView.animate(xAxisDuration: 2.0, easingOption: .EaseOutQuad)
        lineChartView.userInteractionEnabled = false
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1.5, animations: {
            self.salesView.alpha = 1.0
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

