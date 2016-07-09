//
//  BaseAnalytics.swift
//  DiagnosticTool
//
//  Created by Daniel Dorner on 6/22/16.
//  Copyright © 2016 Daniel Dorner. All rights reserved.
//

//This is the base analytics class which handles JSON import
import Foundation
import Alamofire
import UIKit

class BaseAnalytics {
    
    var jsonObj: JSON!
    var serverJson: JSON!
    var name:Double! = 0
    init(jsonPath: String){
        
        
        Alamofire.request(.GET, "http://www.dornerdigital.com/sales/SalesData.json")
            .responseJSON { response in
              //  print(response.request)  // original URL request
              //  print(response.response) // URL response
                //print(response.data)     // server data
               print(response.result.value)   // result of response serialization
                
                if let value = response.result.value {
                    //print("JSON: \(JSON)")
                    let json = JSON(value)
                    
                    //Once this class is called in my viewDidLoad this json value is blank??
                    print(json["salesdata"]["list"][0]["todays_sales"].double!)
                 
                }
        }
        
        
        if let path = NSBundle.mainBundle().pathForResource(jsonPath, ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
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