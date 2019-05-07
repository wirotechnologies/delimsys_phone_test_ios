//
//  Config.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit
import Foundation




class Config: UIViewController {
    
    
    
    static var server: String  = "http://delimsys.com/"
    static var apiPhoneTest: String = server+"drvr/api/phone/tests"

    static var apiSendDriverPushToken: String = server+"drvr/api/drivers/push/tokens"

    static var tokenGuest: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE1NTcxMTQ4MTIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6Imd1ZXNzLmRyaXZlckBkZWxpbXN5cy5jb20iLCJpZCI6MSwiaXAiOiIxODEuMTI5LjE2OC4xMDYiLCJleHAiOjE3MTQ5ODIwMTJ9.SK9FBKfzaaTtZEUfqRbYxLge_mszlegjerjEL-v2lrLMk1Haenjz_RCX8iAf1pLjosudLvt0aEB1uMKOAIi17EVMyuCf5Zb7I0eZT1EEV1PBNt7iDNzkelKctzCpKhXyf85jXQinPostNyCxBWKww8GSvIv4JK1T7NSVeoYfjbTytn-NtdAKD5z-PHupcFRm2uP58ITACYJWrdxbDCarOU9lQRgo4qVar-2HmE4zr_v1_Xz72X_8IR80jNQscEEJrP2vTjuM37yrJYiI51P0yz16xDYJ3T58CswJBgNJldXJ6eKh9JgE0Y133F4nrbVFvycMnZT6uQmSJSBmmPy37DjOSMsfkOLxRx0kvotrR-uyDufVEujYoX7UCRhjZlrRoX6Zz5DPzqc-rjHWlr1jtd75ic-7PjGwqg5INIZv95SvilVjCOrgkfyLCBSQfhrxPukrhxVgF_vFeV4-WDCCTipJmiU0cDxLFxIWEk6GWLKTo9MzYrz7hRLoW_ee6X9iCzxNBpniRpTLdHAWk1w0GkFh80lQnF9_JhERGstf0j9lfqIeqUQv383tpo09odq4pyn9VmI6qdy6CNoaLsg8RQA-k01mufI0eGwNR2shpQLZLPcknvbDSUgMXNUNiFhAIqWO8vnr-eOGDpVttVerJr0kfyuZwZHQlfL92osP56g"

    static var GoogleMapApiKey = "AIzaSyB-H6Q6sS-T5U0Iho7exUZL4ZOfxGtxgUs"
    
    static var elapsedTimeNotification: Float = 0.0
    static var maxTimeNotification: Float = 30.0
    
    
    
}
