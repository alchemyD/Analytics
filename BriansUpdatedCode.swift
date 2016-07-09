import Foundation


class Analytics {
    
    var sales = SalesAnalytics()
    var servers = ServerAnaltics()
    
}

class BaseAnalytics {
    
    var json: JSON!
    
    init(url: String) {
        request(url, (error, json) -> {
            if error != nil
            asdfasdfasdf
            
            self.json = json
            })
        
        //     guard let resourcePath = NSBundle.mainBundle().pathForResource(path, ofType: "json") else {
        //       print("Invalid filename/path.")
        //       return
        //     }
        
        //     do {
        //         let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: resourcePath), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        
        //         guard let self.json = JSON(data: data) else {
        //             print("could not get json from file, make sure that file contains valid json.")
        //             return
        //         }
        //     } catch let error as NSError {
        //         print(error.localizedDescription)
        //     }
    }
    
}

class SalesAnalytics: BaseAnalytic {
    
    var today: Double! = 0
    var yesterday: Double! = 0
    var daily: [Double] = []
    
    init() {
        super(path: "SalesData")
        
        self.today = jsonObj["quotes"]["list"][0]["todays_sales"].double!
        self.yesterday = jsonObj["quotes"]["list"][0]["yesterdays_sales"].double!
        
        //for Loop to append daily_sales array with JSON data
        for (var sale in jsonObj["quotes"]["list"][0]["daily_sales"]) {
            self.daily.append(sale.double!)
        }
        
        a = jsonObj["quotes"]["list"][0]["daily_sales"].map(function (e) {
            return e.double!
            })
        
    }
    
    func percentChangeToday() -> Double {
        return round(((self.today - self.yesterday)/self.yesterday)*1000) / 1000
    }
    
}


//
let a = Analytics()
a.sales.today
a.sales.percentChangetoday()







//------------------------------------------------------------------



class SalesData {
    
    var sales_today:Double! = 0
    var sales_yesterday:Double! = 0
    var daily_sales: [Double] = []
    
    init(){
        if let path = NSBundle.mainBundle().pathForResource("SalesData", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    //MARK: Assign Variables
                    self.sales_today = jsonObj["quotes"]["list"][0]["todays_sales"].double!
                    self.sales_yesterday = jsonObj["quotes"]["list"][0]["yesterdays_sales"].double!
                    //for Loop to append daily_sales array with JSON data
                    for (var i = 0;i<jsonObj["quotes"]["list"][0]["daily_sales"].count;i++){
                        self.daily_sales.append(jsonObj["quotes"]["list"][0]["daily_sales"][i].double!)
                    }
                    //                    print(daily_sales[5])
                    //                    print(jsonObj["quotes"]["list"][0]["daily_sales"].count)
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
}

class SalesDataAnalytics: SalesData {
    
    //MARK: Methods
    func percentChangeToday() -> Double {
        
        return (round(((sales_today - sales_yesterday)/sales_yesterday)*1000) / 1000)
    }
    
    func weeklyAverage() -> Double {
        
        let sum:Double = daily_sales.reduce(0,combine: +)
        let total:Double = Double(daily_sales.count)
        let average = Double(sum / total)
        return average
        
    }
    func weeklyAverageAsString() -> String {
        let averageString = String(weeklyAverage())        
        return averageString
        
    }
    func percentChangeTodayAsString() -> String {
        
        let percentChangeString = String(percentChangeToday())
        return percentChangeString
    }
}






//-------------------------------------------------



import JSON

// DATA MODELS
class Analytics {
    
    var quotes: [Quote] = []
    
    init(json: JSON) {
        super.init()
        
        // Building Quotes Array
        for item in json["quotes"]["list"] {
            let quote = Quote(item)
            self.quotes.append(quote)
        }
    }
    
}

class Quote {
    
    var change_percent: Double = 0
    var todays_sales: Double = 0
    var yesterdays_sales: Double = 0
    var remaining_inventory: Double = 0
    var year_high: Double = 0
    var year_low: Double = 0
    var daily_sales: [Int] = []
    
    init(json: JSON) {
        super.init()
        
        // Building Quotes Array
        self.change_percent = json["chg_percent"].double!
        self.todays_sales = json["todays_sales"].double!
        self.yesterdays_sales = json["yesterdays_sales"].double!
        self.remaining_inventory = json["remaining_inventory"].double!
        self.year_high = json["year_high"].double!
        self.year_low = json["year_low"].double!
        self.daily_sales = json["daily_sales"]
    }
    
    
    changeToday() -> Double {
    return (self.todays_sales - self.yesterdays_sales)/self.yesterdays_sales
    }
    
}


// UIViewController
class Controller: UIViewController {
    
    var analytics: Analytics!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pullData()
        
        NSTimeInterval(60, Selector("pullData"))
    }
    
    
    func pullData() {
        if let path = NSBundle.mainBundle().pathForResource("SalesData", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    self.analytics = Analytics(json: jsonObj)
                    self.updateChart()
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func updateCharts() {
        
        self.charts.data = //.....
            self.charts.update()
        
    }
}

//-------------------------------------------------------------------------------------------
//MARK: Import JSON
if let path = NSBundle.mainBundle().pathForResource("SalesData", ofType: "json") {
    do {
        let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonObj = JSON(data: data)
        if jsonObj != JSON.null {
            //MARK: Assign Variables
            
            salesToday = jsonObj["list"]["resources"][0]["resource"]["fields"]["todays_sales"].double!
            salesYesterday = jsonObj["list"]["resources"][0]["resource"]["fields"]["yesterdays_sales"].double!
        } else {
            print("could not get json from file, make sure that file contains valid json.")
        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
} else {
    print("Invalid filename/path.")
}
//-------------------------------------------------------------------------------------------

{
    "quotes": {
        "meta":{
            "start":0,
            "count":1
        },
        "list": [
        {
        "chg_percent": 13,
        "todays_sales": 230000.00,
        "yesterdays_sales": 123000.00,
        "remaining_inventory":350000.00,
        "year_high": 280000.00,
        "year_low": 89470.00,
        "daily_sales": [
        132000.00, 146000.00, 195000.00, 122000.00,
        126000.00, 111000.00, 25000.00
        ]
        }
        ]
    },
    "server_status": {
        "meta":{
            "start":0,
            "count":1
        },
        "list": [ ]
    }
}

//Other old code to save


//
//  ViewController.swift
//  DiagnosticTool
//
//  Created by Dan Dorner on 6/3/16.
//  Copyright © 2016 Daniel Dorner. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, UITableViewDelegate{
    
    
    //MARK: Outlets
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var salesTodayOutlet: UILabel!
    @IBOutlet weak var salesYesterdayOutlet: UILabel!
    @IBOutlet weak var percentChangedOutlet: UILabel!
    @IBOutlet weak var salesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
              
        
        // Get and prepare the data
        let sales = DataGenerator.data()
        
        // Initialize an array to store chart data entries (values; y axis)
        var salesEntries = [ChartDataEntry]()
        
        // Initialize an array to store months (labels; x axis)
        var salesMonths = [String]()
        var i = 0
        for sale in sales {
            // Create single chart data entry and append it to the array
            let saleEntry = BarChartDataEntry(value: sale.value, xIndex: i)
            salesEntries.append(saleEntry)
            
            // Append the month to the array
            salesMonths.append(sale.month)
            
            i += 1
        }
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(yVals: salesEntries, label: "Sales")
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(xVals: salesMonths, dataSets: [chartDataSet])
        
        // Set bar chart data to previously created data
        chartView.animate(yAxisDuration: 1.5, easingOption: .EaseInOutQuart)
        chartView.data = chartData
        
        salesView.alpha = 0
        

    
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

    //BACKUP code
    //
    //  ViewController.swift
    //  DiagnosticTool
    //
    //  Created by Dan Dorner on 6/3/16.
    //  Copyright © 2016 Daniel Dorner. All rights reserved.
    //
    
    import UIKit
    import Charts
    
    class ViewController: UIViewController, UITableViewDelegate{
        
        //MARK: Declaring Variables
        var analytics = Analytics()
        
        
        //MARK: Outlets
        @IBOutlet weak var chartView: BarChartView!
        @IBOutlet weak var salesTodayOutlet: UILabel!
        @IBOutlet weak var salesYesterdayOutlet: UILabel!
        @IBOutlet weak var percentChangedOutlet: UILabel!
        @IBOutlet weak var salesView: UIView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
            // Do any additional setup after loading the view, typically from a nib.
            
            // Get and prepare the data
            let sales = DataGenerator.data()
            
            // Initialize an array to store chart data entries (values; y axis)
            var salesEntries = [ChartDataEntry]()
            
            // Initialize an array to store months (labels; x axis)
            var salesMonths = [String]()
            var i = 0
            for sale in sales {
                // Create single chart data entry and append it to the array
                let saleEntry = BarChartDataEntry(value: sale.value, xIndex: i)
                salesEntries.append(saleEntry)
                
                // Append the month to the array
                salesMonths.append(sale.month)
                
                i += 1
            }
            // Create bar chart data set containing salesEntries
            let chartDataSet = BarChartDataSet(yVals: salesEntries, label: "Sales")
            // Create bar chart data with data set and array with values for x axis
            let chartData = BarChartData(xVals: salesMonths, dataSets: [chartDataSet])
            
            // Set bar chart data to previously created data
            chartView.animate(yAxisDuration: 1.5, easingOption: .EaseInOutQuart)
            chartView.data = chartData
            salesView.alpha = 0
            
            
            //Update labels
            salesTodayOutlet.text = "$\(String(analytics.sales.salesYesterday()))"
            salesYesterdayOutlet.text = "$\(String(analytics.sales.salesYesterday()))"
            percentChangedOutlet.text = "\(String(analytics.sales.salesPercentChangeToday()))%"
            
            //Calculate and display precentage change
            //var a:Double? = 36.2
            var change:Double? = analytics.sales.salesPercentChangeToday()
            if(change > 0){
                percentChangedOutlet.textColor = UIColor.greenColor()
            }else{
                percentChangedOutlet.textColor = UIColor.redColor()
            }
            
            
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



