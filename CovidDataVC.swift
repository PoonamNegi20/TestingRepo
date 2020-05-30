//
//  ViewController.swift
//  NetworkingProject
//
//  Created by Poonam Negi on 14/05/20.
//  Copyright © 2020 Poonam Negi. All rights reserved.
//

import UIKit

class CovidDataVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       networkSetup()
    }
    
    
    
    
    func networkSetup(){
        
        //setup url
        let url = URL(string: "https://covid-19-data.p.rapidapi.com/help/countries?format=json")

        guard let requestUrl = url  else {
            return
        }
        // setup URL Request :  header, http Method, body(POST)
        
        let header = ["x-rapidapi-host": "covid-19-data.p.rapidapi.com",
                      "x-rapidapi-key": "3694fd6b88mshe30466b24c61b41p1ad7ecjsn1091e82df4d5"]
var request = URLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    request.allHTTPHeaderFields = header
     request.httpMethod = "GET"
    
        // Setup URL Session : Data Task

        let session = URLSession.shared
//        let dataTask = session.dataTask(with: requestUrl, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//        })
//        dataTask.resume()
      
        
        // MARK : third method
        let task = session.dataTask(with: requestUrl) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            // serialise the data / NSData object into Dictionary [String : Any]
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print("gotten json response dictionary is \n \(json)")
            // update UI using the response here
        }
        
        // execute the HTTP request
        task.resume()
        
        
    }


}

