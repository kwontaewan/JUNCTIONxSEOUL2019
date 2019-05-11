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
        return UserDefaults.standard.string(forKey: "Authorization") != nil
    }
    
    class func getSessionToken() -> String? {
        return UserDefaults.standard.string(forKey: "Authorization")
    }
    
    class func removeSession() {
        UserDefaults.standard.removeObject(forKey: "Authorization")
    }
    
    class func setAuthToken(authToken: String) {
        UserDefaults.standard.set(authToken, forKey: "Authorization")
    }
    
}
