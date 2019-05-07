//
//  Alerts.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//


import UIKit

class Alerts {
    //alert no custom action onebutton
    static func alertOneButton(title: String, message: String, titleBtn: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: titleBtn, style: UIAlertAction.Style.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    //alert custom action onebutton
    static func alertOneButtonCustomAction(title: String, message: String, titleBtn: String, viewController: UIViewController, responseBlock: @escaping (_ isOk: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let btn1 = UIAlertAction(title: titleBtn, style: UIAlertAction.Style.default) {(action: UIAlertAction) in
            responseBlock(true)
            alert.dismiss(animated: true, completion: nil)
            print("hace la cosa")
        }
        alert.addAction(btn1)
        viewController.present(alert, animated: true, completion: nil)
    }
    //alert one custom action, and cancel button
    static func alertOneButtonCustomActionAndCancel(title: String, message: String, titleBtn1: String, titleBtn2: String, viewController: UIViewController, responseBlock: @escaping (_ isOk: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let btn1 = UIAlertAction(title: titleBtn1, style: UIAlertAction.Style.default) {(action: UIAlertAction) in
            responseBlock(true)
            alert.dismiss(animated: true, completion: nil)
            print("hace la cosa")
        }
        let btn2 = UIAlertAction(title: titleBtn2, style: UIAlertAction.Style.cancel) { (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(btn1)
        alert.addAction(btn2)
        viewController.present(alert, animated: true, completion: nil)
    }
    //alert two custom actions
    static func alertTwoButtonsCustomAction(title: String, message: String, titleBtn1: String, titleBtn2: String, viewController: UIViewController, responseBlock1: @escaping (Bool) -> Void, responseBlock2: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let btn1 = UIAlertAction(title: titleBtn1, style: UIAlertAction.Style.default) {(action: UIAlertAction) in
            responseBlock1(true)
            alert.dismiss(animated: true, completion: nil)
        }
        let btn2 = UIAlertAction(title: titleBtn2, style: UIAlertAction.Style.cancel) { (action: UIAlertAction) in
            responseBlock2(true)
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(btn1)
        alert.addAction(btn2)
        viewController.present(alert, animated: true, completion: nil)
    }
}



