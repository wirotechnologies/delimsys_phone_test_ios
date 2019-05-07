//
//  HomeViewController.swift
//  Delimsys Phone Test
//
//  Created by imac on 3/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import AVFoundation

class HomeViewController: UIViewController, UITextFieldDelegate, GPSControllerDelegate {
    
    func refreshDriverLocation(location: CLLocationCoordinate2D) {
        print("abajo latitud y longitud")
        print(location.latitude)
        print(location.longitude)
        self.GPSLong = location.longitude
        self.GPSLat = location.latitude
    }
    
    var gpsController = GPSController()
    weak var activeField: UITextField?
    var Moved: Bool = false
    var IntroFields: Bool = false
    var GPSLong:Double = 0.0
    var GPSLat:Double = 0.0
    
    @IBOutlet weak var phoneNumberTfld: UITextField!
    @IBOutlet weak var viewContainer: UIStackView!
    @IBOutlet weak var spinner: spinner!
    @IBOutlet weak var startTestBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTouch()
        
        gpsController.delegate = self
        gpsController.startReceivingLocationChanges()

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([doneButton], animated:false)
        
        self.phoneNumberTfld.inputAccessoryView = toolBar
        //changing status var color
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {
            return
        }
        statusBarView.backgroundColor = UIColor.white

        let center: NotificationCenter = NotificationCenter.default;
        
        center.addObserver(self, selector:#selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object:nil)
        center.addObserver(self, selector:#selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object:nil)

    }
    /**********************************************************************
     Created by Diego Paredes    Date: 05/03/2019
     Handling the keyboard
     **********************************************************************/
    @objc func doneClicked(){
        if self.activeField != nil {
            let tagNumber = self.activeField!.tag
            OperationQueue.main.addOperation {
                self.view.endEditing(true)
                let nextTag = tagNumber + 1
                var nextResponder = self.activeField!.superview?.viewWithTag(nextTag)
                self.startTestBtnAction(self)
                nextResponder?.becomeFirstResponder()
            }
            self.IntroFields = true
        }
        self.Moved = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.startTestBtnAction(self)
        self.DismissKeyboard()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    @objc func keyboardDidShow(notification:NSNotification) {
        if(activeField != nil){
            let heightOfView:CGFloat = self.view.frame.size.height
            let _:CGFloat = self.view.frame.maxY
            let info = notification.userInfo
            let rect:CGRect = info!["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            let rect2:CGFloat = (activeField?.frame.maxY)!
            if (rect2+((rect.maxY-heightOfView)/2) >= rect.maxY - rect.minY){
                viewContainer.transform = CGAffineTransform(translationX: 0, y: -1*(rect.size.height-40))
                self.Moved = true
            }
        }
    }
    @objc func keyboardWillHide(notification:NSNotification    ) {
        if(activeField != nil){
            if((Moved && !IntroFields) || ((activeField?.tag)! == 0) ){
                viewContainer.transform = CGAffineTransform(translationX: 0, y: 0)
                self.Moved = false
            }
            self.IntroFields = false
        }
    }
    private func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String){
        let _:CGFloat = textField.frame.maxY
    }
    /**********************************************************************
     Created by Diego Paredes    Date: 05/03/2019
     To get the model phone
     **********************************************************************/
    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    func hideSpinner(){
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.startTestBtnOutlet.isEnabled = true
        }
    }
    func showSpinner(){
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        self.startTestBtnOutlet.isEnabled = false
    }
    /**********************************************************************
     Created by Diego Paredes    Date: 05/03/2019
     Action Button to make the test
     **********************************************************************/
    @IBAction func startTestBtnAction(_ sender: Any) {
        //let osVersion = ProcessInfo().operatingSystemVersion
        
        self.gpsController.refreshDriverLocation()
        
        self.showSpinner()
        
        let osVersion = UIDevice.current.systemVersion
        let modelDevice = modelIdentifier()
        let model = UIDevice.current.localizedModel
        let tes = ""
        let params = [
            "phoneNumber":self.phoneNumberTfld.text,
            "os":"1",
            "osVersion":String(osVersion),
            "phoneBrand":"IPhone",
            "phoneModel":modelDevice,
            "lat":self.GPSLat,
            "lgt":self.GPSLong,
            "createdDate":Common.getDate(),
            "notificationToken": "dsfsdfgsdfsdfds"//UserDefaults.standard.object(forKey: "deviceToken") as! String
            ] as [String : Any]
        
        
        if UserDefaults.standard.bool(forKey: "testSended") == true {
            
            let idRecord = String(UserDefaults.standard.object(forKey: "idRecord") as! Int)
            print(idRecord)
            Requests.requestDictionary(urlArg: Config.apiPhoneTest + "/" + idRecord, paramsArg: params, methodArg: "PUT"){ data in
                if data["error"] as? Bool != nil && data["error"] as! Bool == true {
                    DispatchQueue.main.async {
                        Alerts.alertOneButton(title: "Request Error", message: "Please Verify your inputs and try again", titleBtn: "Ok", viewController: self)
                    }
                } else {
                    DispatchQueue.main.async {
                        Alerts.alertOneButton(title: "Device Information", message: "Your phone is an " + model + " with and OS version " + osVersion, titleBtn: "Ok", viewController: self)
                    }
                }
                print(data)
                self.hideSpinner()
            }
            
        } else {
            
            Requests.requestDictionary(urlArg: Config.apiPhoneTest, paramsArg: params, methodArg: "POST"){ data in
                if data["error"] as? Bool != nil && data["error"] as! Bool == true {
                    DispatchQueue.main.async {
                        Alerts.alertOneButton(title: "Request Error", message: "Please Verify your inputs and try again", titleBtn: "Ok", viewController: self)
                    }
                } else {
                    print(data)
                    DispatchQueue.main.async {
                        Alerts.alertOneButton(title: "Device Information", message: "Your phone is an " + model + " with and OS version " + osVersion, titleBtn: "Ok", viewController: self)
                            UserDefaults.standard.set(data["id"], forKey: "idRecord")
                            UserDefaults.standard.set(true, forKey: "testSended")
                    }
                }
                self.hideSpinner()
            }
            
        }
        
        

        
        
        
        
        
        
    }
    
}
