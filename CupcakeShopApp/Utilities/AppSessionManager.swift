//
//  AppSessionManager.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation

public class AppSessionManager {
    
    class func isSession() -> Bool {
        return UserDefaults.standard.string(forKey: "refresh") != nil
    }
    
    class func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refresh")
    }
    
    class func removeSession() {
        UserDefaults.standard.removeObject(forKey: "refresh")
    }
    
    class func setRefreshToken(authToken: String) {
        UserDefaults.standard.set(authToken, forKey: "refresh")
    }
    
    class func setAuthToken(authToken :String) {
        UserDefaults.standard.set(authToken, forKey: "Authorization")
    }
    
    class func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: "Authorization")
    }
    
}
