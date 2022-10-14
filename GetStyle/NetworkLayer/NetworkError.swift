//
//  NetworkError.swift
//  NextGeni Network Layer
//  Created by Saad Ali Khan on 04/08/2022.
//  Copyright © 2022 Next Generation Innovation. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case noInternetConnection
    case genericError
    case failedLoadingCountries
    case custome(message: String)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("Please check your internet connection", comment: "Error when some of the details are wrong.")
        case .genericError:
            return NSLocalizedString("Something went wrong", comment: "Error in parsing Family")

        case .failedLoadingCountries:
            return NSLocalizedString("Unable to load Countries Data", comment: "Unable to load Countries")
        case .custome(let message):
            return NSLocalizedString(message, comment: "Unable to load Countries")
        }
    }
}
