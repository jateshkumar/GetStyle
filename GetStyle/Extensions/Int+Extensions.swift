//
//  Int+Extention.swift
//  Orko
//
//  Created by Jatesh Kumar Maheshwari on 15/08/2022.
//

import Foundation
import UIKit

extension Int {
    var boolValue: Bool {
        return self != 0
    }
    
    func getFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            return "\(self)"
        }
        return formattedNumber
    }
    
    var status: HttpStatusCode {
        switch self {
        case 200:
            return .success
        case 401:
            return .unauthorized
        case 422:
            return .validation
        case 400...499:
            return .failure
        case 500...599:
            return .serverError
        default:
            return .unknown
        }
    }
    
    var OKStatus: HttpOKCode {
        switch self {
        case 1:
            return .success
        case 0:
            return .failure
        default:
            return .failure
        }
    }
    
}
