//
//  String.swift
//  CupcakeShopApp
//
//  Created by Gunter on 11/05/2019.
//  Copyright © 2019 Gunter. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
