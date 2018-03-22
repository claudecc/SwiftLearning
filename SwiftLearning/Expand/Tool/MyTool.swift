//
//  MyTool.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/22.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

struct UserDefaultKeys {
    // 账户信息
    struct AccountInfo {
        let userName = "userName"
        let password = "password"
    }
    // 登录信息
    struct LoginInfo {
        let token = "token"
        let userId = "userId"
    }
    // 配置信息
    struct SettingInfo {
        let font = "font"
        let backgroundImage = "backgroundImage"
    }
}

class MyTool: NSObject {
    
    class func isLogin () -> Bool {
        let userId : String? = MyTool.readValueForKey(key: UserDefaultKeys.LoginInfo().userId) as? String
        if userId != nil {
            return true
        }
        return false
    }
    
    class func writeValueForKey(value:Any?, key:String?) {
        if let saveValue = value, let saveKey = key {
            let userDefault = UserDefaults.standard
            userDefault.set(saveValue, forKey: saveKey)
        }
    }
    
    class func readValueForKey(key:String) -> Any? {
        let userDefault = UserDefaults.standard
        return userDefault.object(forKey: key)
    }
    
}
