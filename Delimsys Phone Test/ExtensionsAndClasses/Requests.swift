//
//  Requests.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit
import Foundation

struct requestInfo {
    var url = String()
    var method = String()
    var parameters = [String:Any]()
}

class Requests {
    
    
    static func httpRequest(url: String, httpBody : Any = [:] , methodArg: String, authApiToken: String = "", responseData:  @escaping ([String:Data]) ->()){
        //print(url)
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: []) else { return }
        if methodArg != "GET" {
            request.httpBody = httpBody
        }
        request.httpMethod = methodArg
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authApiToken)", forHTTPHeaderField: "Authorization")
        //print("authApiToken:\(authApiToken)")
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            do {
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode >= 200 && httpResponse.statusCode < 400 {
                        let statusCodeData = String(httpResponse.statusCode).data(using: .utf8)
                        let responseFrom  = ["statusCode": statusCodeData, "data":data]
                        responseData(responseFrom as! [String : Data])
                    }else{
                        let statusCodeData = String(httpResponse.statusCode).data(using: .utf8)
                        let responseFrom  = ["statusCode": statusCodeData, "data":data]
                        responseData(responseFrom as! [String : Data])
                    }
                }
            }
            }.resume()
    }
    
    static func getIdFromHttpData(data: Data) -> Int{
        var id = Int()
        do{
            var json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            id = Int(truncating: json["id"] as! NSNumber)
        }catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return id
    }
    
    
    static func generalRequest (urlArg: String, paramsArg: Any, methodArg: String, accesstokenArg:String = "", responseData: @escaping (_ data: Data) -> ()) {
        guard let url = URL(string: urlArg) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodArg
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accesstokenArg)", forHTTPHeaderField: "Authorization")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: paramsArg, options: []) else { return }
        if methodArg != "GET" {
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        session.dataTask(with: request){ (data, response, error) in
            print(data!.base64EncodedString())
            do{
                let dataString =  String(data: data!, encoding: String.Encoding.utf8)
                //print("Answer:",dataString ?? "no data")
                //print(dataString)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode >= 200 && httpResponse.statusCode < 400 {
                        if let data = data {
                            do {
                                responseData(data)
                            }
                        }
                    } else {
                        print("Error: " + String(httpResponse.statusCode))
                        responseData(Data(String(httpResponse.statusCode).utf8))
                    }
                }
            }
            }.resume()
    }
    
    
    static func requestArrayDictionary (urlArg: String, paramsArg: Any, methodArg: String, accesstokenArg:String = "", viewController: UIViewController = UIViewController(), responseData: @escaping (_ data: [Dictionary<String, Any>]) -> ()){
        generalRequest(urlArg: urlArg, paramsArg: paramsArg, methodArg: methodArg, accesstokenArg: accesstokenArg){ data in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String,Any>]
                responseData(json!)
            } catch {
                print("error")
            }
        }
    }
    
    static func requestDictionary (urlArg: String, paramsArg: Any, methodArg: String, accesstokenArg:String = Config.tokenGuest, responseData: @escaping (_ data: Dictionary<String, Any>) -> ()){
        generalRequest(urlArg: urlArg, paramsArg: paramsArg, methodArg: methodArg, accesstokenArg: accesstokenArg){ data in
            do {
                //print(data)
                //print(data.base64EncodedString())
                let json = try JSONSerialization.jsonObject(with: data) as? Dictionary<String,Any>
                responseData(json!)
            } catch {
                responseData(["error":true])
                print("error")
            }
        }
    }
    
    
    
    
}

