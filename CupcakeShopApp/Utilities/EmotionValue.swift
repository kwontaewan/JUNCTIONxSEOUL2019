//
//  EmotionValue.swift
//  CupcakeShopApp
//
//  Created by Gunter on 12/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation

public class EmotionValue {
    
    class func getIdx(value: String) -> Int {
        switch value {
        case "happiness":
            return 1
        case "surprise":
            return 2
        case "anger":
            return 3
        case "sadness":
            return 4
        case "calm":
            return 5
        case "fear":
            return 6
        case "disgust":
            return 7
        default:
            return 1
        }
    }
    
}
