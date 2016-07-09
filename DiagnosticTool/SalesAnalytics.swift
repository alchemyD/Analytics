//
//  SalesAnalytics.swift
//  DiagnosticTool
//
//  Created by Daniel Dorner on 6/22/16.
//  Copyright © 2016 Daniel Dorner. All rights reserved.
//

import Foundation

class SalesAnalytics: BaseAnalytics {
    
    var today: Double! = 0
    var yesterday: Double! = 0
    var daily: [Double] = []
    var quarterly: [Double] = []
    
    init() {
        super.init(jsonPath: "SalesData")
        
        
       self.today = jsonObj["salesdata"]["list"][0]["todays_sales"].double!
       self.yesterday = jsonObj["salesdata"]["list"][0]["yesterdays_sales"].double!
        
        //for Loop to append daily_sales array with JSON data
        for (var i, sale) in jsonObj["salesdata"]["list"][0]["daily_sales"] {
            self.daily.append(sale.double!)
        }
        //for Loop to append daily_sales array with JSON data
        for (var i, sale) in jsonObj["salesdata"]["list"][0]["quarterly_sales"] {
            self.quarterly.append(sale.double!)
        }
    }
    
    var percentChangeToday: Double {
        get {
            return (round(((today - yesterday)/yesterday)*1000) / 1000)
        }
    }
    var weeklyAverage: Double {
        get {
            let sum:Double = daily.reduce(0,combine: +)
            let total:Double = Double(daily.count)
            let average = Double(sum / total)
            return round(average)
        }
    }
    
}