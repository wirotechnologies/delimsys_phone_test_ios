//
//  Common.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}

class Common {
    
    static func getDate() -> String {
        
        let currentDateFormatter = DateFormatter()
        let currentDate = Date()
        currentDateFormatter.dateStyle = .short
        currentDateFormatter.timeStyle = .short
        let currentDateString = currentDateFormatter.string(from: currentDate)
        return currentDateString
    }
    
    static func doLogin(urlLoginApi: String, userName: String, password: String, response: @escaping ([String:String]) -> ()){
        var res: [String:String] = [:]
        let bodyRequest = ["email": userName, "password": password]
        Requests.httpRequest(url: urlLoginApi, httpBody: bodyRequest, methodArg: "POST"){ data in
            do{
                let statusCode = String.init(data: data["statusCode"]!, encoding: .utf8)
                if statusCode == "200"
                {
                    var json = try JSONSerialization.jsonObject(with: data["data"]!, options: []) as! [String: AnyObject]
                    let token = json["token"] as! String
                    res = ["sucess":"true","token":token]
                }else{
                    if statusCode == "401"{
                        res = ["sucess":"401"]
                    }
                }
                response(res)
            }catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
   /*
    static func decodeJWT(token: String) -> [String: AnyObject]{
        let tokenArray = token.components(separatedBy: ".")
        var payload = tokenArray[1]
        var json : [String: AnyObject] = [:]
        print(payload)
        if payload.count % 4 != 0 {
            let padlen = 4 - payload.count % 4
            payload.append(contentsOf: repeatElement("=", count: padlen))
        }
        let payLoadData = Data(base64Encoded: payload, options: .ignoreUnknownCharacters)
        do{
            json = try JSONSerialization.jsonObject(with: payLoadData!, options: []) as! [String: AnyObject]
            return json
        }catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return json
    }
    
    
    static func getRequestDriverByStatus(urlLoginApi: String, idDriver: Int, status: Int, apiToken: String,  requestDriver: @escaping ([String:Any] ) -> ()){
        var res: [String:Any] = [:]
        var infoDriver = RequestDriver()
        print("\(Config.apiGetOrdersByStatusDriver)/\(idDriver)/\(status)")
        Requests.httpRequest(url: "\(Config.apiGetOrdersByStatusDriver)/\(idDriver)/\(status)", methodArg: "GET", authApiToken: apiToken){ data in
            do{
                let statusCode = String.init(data: data["statusCode"]!, encoding: .utf8)
                if statusCode == "200"
                {
                    print(data["data"]!)
                    var dataDictionary = try JSONSerialization.jsonObject(with: data["data"]!, options: []) as? [[String: AnyObject]] ?? []
                    print(dataDictionary.isEmpty)
                    if !dataDictionary.isEmpty {
                        
                        let addressPickup = dataDictionary[0]["idAddressesPickup"] as! [String: AnyObject]
                        let store = dataDictionary[0]["store"] as! [String: AnyObject]
                        infoDriver.address = addressPickup["address"] as! String
                        infoDriver.name = store["name"] as! String
                        infoDriver.lat = addressPickup["lat"] as! Double
                        infoDriver.lng = addressPickup["lng"] as! Double
                        infoDriver.status = 1
                        let distanceMin: String = dataDictionary[0]["distance_min"] as! String
                        let distanceMiles: String  = dataDictionary[0]["distance_miles"] as! String
                        
                        infoDriver.distance =  "\(distanceMin)Min,  \(distanceMiles)Miles"
                        print(infoDriver.distance)
                        res = ["sucess":"true","request":infoDriver]
                    }
                    else{
                        res = ["sucess":"false"]
                    }
                }else{
                    if statusCode == "401"{
                        res = ["sucess":"401"]
                    }
                }
                requestDriver(res)
            }catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }*/
}

