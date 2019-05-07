//
//  AppDelegate.swift
//  Delimsys Phone Test
//
//  Created by Wilman Rojas on 5/3/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive response")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent notification")
        completionHandler([.badge, .alert, .sound])
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        print("identifier = \(identifier)")
    }
    
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print("identifier = \(identifier)")
    }
    
   /* func getTokenGuest(){
        Common.doLogin(urlLoginApi: Config.apiLogin, userName: Config.userGuest, password: Config.passGuest){ response in
            if response["sucess"] == "true" {
                UserDefaults.standard.setValue( response["token"], forKey: "apiTokenGuest")
            }
        }
    }*/

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().delegate = self
        application.isIdleTimerDisabled = true
        //getTokenGuest()
        self.setupPushNotifications(application: application)
        return true
        
    }

    /********START NOTIFICATIONS FUNCTIONS************/
    
    func setupPushNotifications(application: UIApplication) -> (){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
            (granted, error) in
            if(granted){
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }else{
                print("Service Denegade")
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ){
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("abajo el token device")
        print(token)
        UserDefaults.standard.setValue(token, forKey: "deviceToken")
        print(UserDefaults.standard.object(forKey: "deviceToken") as! String)
        

        
        
        
    //llamar api y meter los datos
        //ese token de arriba lo envío
        //cómo capturar datos de celular modelo y versión
        /*
         EL DO LOGIN
         Common.doLogin(urlLoginApi: Config.apiLogin, userName: Config.userGuest, password: Config.passGuest){ response in
            if response["sucess"] == "true" {
                UserDefaults.standard.setValue( response["token"], forKey: "apiTokenGuest")
                if UserDefaults.standard.object(forKey: "idToken") == nil{
                    PushTokenController.postPushToken(urlApi: Config.apiSendDriverPushToken, createdDate: Common.getDate(), idAppOs: "1", idPushTokenStatus: "1", pushToken: token, authApiToken: response["token"]! ){ response in
                        UserDefaults.standard.setValue(response, forKey: "idToken")
                    }
                }
            }
        }
         EL DO LOGIN*/
        
        
    }

    
    
    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

