//
//  Constants.swift
//  Interview
//
//  Created by Londre Blocker on 4/24/16.
//  Copyright © 2016 Londre Blocker. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

typealias JSONArray = Array<AnyObject>

struct Constants {
    struct Network {
        static let WiFi = "Wifi Available"
        static let NoAcess = "No Internet Access"
        static let WWAN = "Cellular Access Available"
    }
}