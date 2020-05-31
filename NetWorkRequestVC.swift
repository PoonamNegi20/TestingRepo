//
//  NetWorkRequestVC.swift
//  NetworkingProject
//
//  Created by Poonam Negi on 14/05/20.
//  Copyright © 2020 Poonam Negi. All rights reserved.
//

import UIKit

class NetWorkRequestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  makingGetRequest()
 makingPostRequest()
        
    }
    
    
    
    
    func makingGetRequest(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://httpbin.org/anything")!
        let task = session.dataTask(with: url) { data, response, error in
            
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

    
    
    
    
    
    func makingPostRequest(){
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://httpbin.org/anything")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // your post request data
        let postDict : [String: Any] = ["name": "axel",
                                        "favorite_animal": "fox"]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: postDict, options: []) else {
            return
        }
        
        urlRequest.httpBody = postData
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
