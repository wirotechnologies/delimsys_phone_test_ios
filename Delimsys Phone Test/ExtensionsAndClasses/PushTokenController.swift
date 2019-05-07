//
//  PushTokenController.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import Foundation

class PushTokenController {
    
    
    private var id = Int()
    private var idAppOs = Int()
    private var idPushTokenStatus = Int()
    private var idDrivers = Int()
    private var token = String()
    private var updatedDate = String()
    private var createdDate = String()
    
    init(idAppOs: Int)
    {
        self.idAppOs = idAppOs
    }
    
    func getId() -> Int{
        return self.id
    }
    
    func setIdAppOs(idAppOs : Int){
        self.idAppOs = idAppOs
    }
    
    func getIdAppOs() -> Int{
        return self.idAppOs
    }
    
    func setIdPushTokenStatus(idPushTokenStatus : Int){
        self.idPushTokenStatus = idPushTokenStatus
    }
    
    func getIdPushTokenStatus() -> Int{
        return self.idPushTokenStatus
    }
    
    func setIdDrivers(idDrivers : Int){
        self.idAppOs = idDrivers
    }
    
    func getIdDrivers() -> Int{
        return self.idDrivers
    }
    
    
    static func postPushToken (urlApi: String, createdDate: String, idAppOs: String, idPushTokenStatus: String, pushToken : String!, authApiToken: String = "", idPushToken: @escaping (Int) -> ()){
        
        let paramsArg = [
            "createdDate": Common.getDate(),
            "idAppOs": idAppOs,
            "idPushTokenStatus": idPushTokenStatus,
            "token": pushToken
        ]
        
        Requests.httpRequest(url: urlApi, httpBody: paramsArg, methodArg: "POST", authApiToken: authApiToken) { data in
            do{
                let statusCode = String.init(data: data["statusCode"]!, encoding: .utf8)
                if statusCode == "201" {
                    idPushToken(Requests.getIdFromHttpData(data: data["data"]!))
                }
            }
        }
    }
        
    static func putPushToken (urlApi: String, httpBody: Any, idToken: Int, authApiToken: String, statusCode: @escaping (Int) -> ()){
        Requests.httpRequest(url: "\(urlApi)/\(idToken)", httpBody: httpBody, methodArg: "PUT", authApiToken: authApiToken) { data in
            do{
                let httpCode = String.init(data: data["statusCode"]!, encoding: .utf8)
                statusCode(Int(httpCode!)!)
            }
        }
    }
    
    
    
}


