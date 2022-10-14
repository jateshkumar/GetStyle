//
//  NetworkConstants.swift
//  Orko
//
//  Created by Jatesh Kumar Maheshwari on 15/08/2022.
//

enum BaseUrlVersion: String {
    case version1 = "v1"
    case version2 = "v2"
}

struct NETWORKCONSTANTS {

    static let env = getEnvType()

    static func getBaseUrl(with version: BaseUrlVersion) -> String {
        switch self.env {
        case .dev:
            return "https://orko-apis.herokuapp.com/"
        case .qa:
            return "https://"
        case .stage:
            return "https://"
        case .release:
            return "https://"
        }
    }
    
    static func getClientSecret() -> String {
        switch self.env {
        case .dev:
            return ""
        case .qa:
            return ""
        case .stage:
            return ""
        case .release:
            return ""
        }
    }
}
