//
//  ApiEndPoints.swift
//  NextGeni Network Layer
//  Created by Saad Ali Khan on 04/08/2022.
//  Copyright © 2022 Next Generation Innovation. All rights reserved.
//
import Foundation

/*========================================================================*/

enum ApiEndPoints {
    
    case user(User)
    case chargingStation(_ lat: String, _ long: String, _ searchText: String)
    
    var methodName: String {
        switch self {
        case .user(let user):
            return "users/" +  user.rawValue
        case .chargingStation(let lat, let long, let searchText):
            return "charging-station/nearest?latitude=\(lat)&longitude=\(long)&name=\(searchText)"
        }
    }
}

/*========================================================================*/

enum User: String {
    case login
}
