//
//  ServerAnalytics.swift
//  
//
//  Created by Daniel Dorner on 7/9/16.
//
//

import Foundation
import Alamofire

class ServerAnalytics {
    
    var today: Double! = 0
    var yesterday: Double!
    var daily: [Double] = []
    var quarterly: [Double] = []
    var timerExtended = NSTimer()

    var serverJson:JSON!
    
    @objc func run(){
        
        Alamofire.request(.GET, "http://www.dornerdigital.com/sales/SalesData.json")
            .responseJSON { response in
                //  print(response.request)  // original URL request
                //  print(response.response) // URL response
                //print(response.data)     // server data
                print(response.result.value)   // result of response serialization
                
                if let value = response.result.value {
                    //print("JSON: \(JSON)")
                    self.serverJson = JSON(value)
                    
                    //Once this class is called in my viewDidLoad this json value is blank??
                    print(self.serverJson["salesdata"]["list"][0]["todays_sales"].double!)
                    
                    self.today = self.serverJson["salesdata"]["list"][0]["todays_sales"].double!
                    self.yesterday = self.serverJson["salesdata"]["list"][0]["yesterdays_sales"].double!
                    
                    //for Loop to append daily_sales array with JSON data
                    for (var i, sale) in self.serverJson["salesdata"]["list"][0]["daily_sales"] {
                        self.daily.append(sale.double!)
                    }
                    //for Loop to append daily_sales array with JSON data
                    for (var i, sale) in self.serverJson["salesdata"]["list"][0]["quarterly_sales"] {
                        self.quarterly.append(sale.double!)
                    }
            }
        }
        
    }
   
     init(){
        
        
        run()
        timerExtended = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(run), userInfo: nil, repeats: true)
       

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