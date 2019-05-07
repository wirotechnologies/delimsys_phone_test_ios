//
//  GPSController.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//
import Foundation
import CoreLocation


protocol GPSControllerDelegate: class {
    func refreshDriverLocation( location: CLLocationCoordinate2D)
}


class GPSController: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: GPSControllerDelegate?
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        print("ini")
        locationManager.delegate = self
    }
    
    /**********************************************************************
     Created by Wilman Rojas   Date:
     Updated by Wilman Rojas    Date: 01/19/2019
     Method to initialize the reception of GPS
     **********************************************************************/
    public func startReceivingLocationChanges() {
        
        locationManager.delegate = self
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            enableLocationServices()
            
            return
        }
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
        locationManager.startUpdatingLocation()
        
        return
    }
    
    /**********************************************************************
     Created by Wilman Rojas   Date: 01/19/2019
     Updated by Wilman Rojas    Date: 01/19/2019
     Method to get location and prepare for send to server Delimsys
     **********************************************************************/
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        sendLocation()
        refreshDriverLocation()
    }*/
    
    /**********************************************************************
     Created by Wilman Rojas   Date:
     Updated by Wilman Rojas    Date: 01/19/2019
     Method to send location data to server Delimsys
     **********************************************************************/
    /*func sendLocation(){
        let params = [
            "date" : Common.getDate(),
            "idDriver": "\(UserDefaults.standard.object(forKey: "idUser") as! Int)",
            "lat": "\(locationManager.location!.coordinate.latitude)",
            "lng": "\(locationManager.location!.coordinate.longitude)"
            ] as [String : Any]
        Requests.httpRequest(url: Config.apiSetLocation, httpBody: params, methodArg: "POST", authApiToken: UserDefaults.standard.object(forKey: "accessToken") as! String){ httpResponse in
            do{
                let statusCode = String.init(data: httpResponse["statusCode"]!, encoding: .utf8)
                if statusCode == "200" ||  statusCode == "201" {
                    print("Sent location")
                }else{
                    print(statusCode as Any)
                }
            }
        }
    }*/
    /**********************************************************************
     Created by Wilman Rojas   Date:
     Updated by Wilman Rojas    Date: 01/19/2019
     Method to enable and request authorization for use GPS
     **********************************************************************/
    func enableLocationServices(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestAlwaysAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            // disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            // enableMyWhenInUseFeatures()
            break
        }
    }
    
    /**********************************************************************
     Created by Wilman Rojas   Date:
     Updated by Wilman Rojas    Date: 01/19/2019
     Method to enable and request authorization for use GPS
     **********************************************************************/
    func refreshDriverLocation()
    {
        delegate?.refreshDriverLocation(location: locationManager.location!.coordinate)
    }
}

