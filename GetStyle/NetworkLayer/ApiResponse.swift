//
//  APIResponse.swift
//  NextGeni Network Layer
//  Created by Saad Ali Khan on 04/08/2022.
//  Copyright © 2022 Next Generation Innovation. All rights reserved.
//

import Foundation

class ApiResponse<T>: Codable where T: Codable {
    
    var okCode: Int?
    var message: String?
    var data: T?
    var updateAvailable: Int?
    var errors: [String]?
    
    enum CodingKeys: String, CodingKey {
        case okCode = "OK"
        case data = "data"
        case message = "message"
//        case updateAvailable = "update_available"
//        case errors = "errors"
    }
    
    required public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        okCode = try values.decodeIfPresent(Int.self, forKey: .okCode) ?? nil
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? nil
//        updateAvailable = try values.decodeIfPresent(Int.self, forKey: .updateAvailable) ?? nil
        
        if let data = try? values.decodeIfPresent(T.self, forKey: .data) {
            self.data = data
        } else {
            self.data = nil
        }
        
//        if let errors = try? values.decode([String].self, forKey: .errors) {
//            self.errors = errors
//        } else {
//            self.errors = []
//        }
    }
}
