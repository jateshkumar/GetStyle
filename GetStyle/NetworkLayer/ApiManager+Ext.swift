//
//  ApiManager+Ext.swift
//  NextGeni Network Layer
//  Created by Saad Ali Khan on 04/08/2022.
//  Copyright © 2022 Next Generation Innovation. All rights reserved.
//

import Foundation

/*========================================================================*/

struct EmptyModel: Codable {
}

/*========================================================================*/

enum CompletionResponse {
    case success
    case failure(errorMessage: String?, errorDetails: String?)
}

/*========================================================================*/
extension ApiManager {
    // MARK: - Update Code Here
}

/*========================================================================*/

extension ApiManager {
    
    func showErrorIfAllowed(error: Error) {
        if self.showError {
            showServerError(with: "", message: error.localizedDescription)
        }
    }
    
    // MARK: Unauthorized User
    func logoutUser() {
        // MARK: - Logout User Code here
    }
}
/*========================================================================*/
