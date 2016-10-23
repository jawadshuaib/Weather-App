//
//  ViewController.swift
//  Weather App
//
//  Created by Jawad Shuaib on 2016-10-22.
//  Copyright © 2016 Jawad Shuaib. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var desc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func getWeatherInfo(_ sender: AnyObject) {
        
        if let city = inputText.text {
            let trimmedCity = city.stringByRemovingWhitespaces
            
            if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(trimmedCity)&appid=f2a1e56d3efcdd8bb580013fb1d2da96") {
                
                let task = URLSession.shared.dataTask(with: url, completionHandler: {
                    (data, response, err) in
                    
                    if err != nil {
                        self.resultLabel.text = "Could not process data"
                    } else {
                        
                        if let result = data {
                            
                            do {
                                let json = try JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                                
                                if let weather = json["weather"] as? NSArray {
                                    let el = weather[0] as? [String: Any]
                                    for (key, val) in el! {
                                        if key == "description" {
                                            
                                            DispatchQueue.main.sync (execute: {
                                                self.resultLabel.text = "\(val)"
                                            })
                                        }
                                    }
                                }
                            } catch let err as NSError {
                                
                                self.resultLabel.text = "Problem processing data \(err)"
                            }
                            
                        } else {
                            self.resultLabel.text = "Try a different city"
                        }
                    }
                    
                })
                
                task.resume()
            } else {
                resultLabel.text = "Please enter city"
            }
        }

        }
}

