//
//  ApiManager.swift
//  NextGeni Network Layer
//  Created by Saad Ali Khan on 04/08/2022.
//  Copyright © 2022 Next Generation Innovation. All rights reserved.
//

import Foundation
import Alamofire
import Network

/*========================================================================*/

public class ApiManager<T> where T: Codable {
    
    private let successHandler: (T) -> Void
    private let nullDataSuccessHandler: ((HttpStatusCode) -> Void)?
    private let errorHandler: (_ statusCode: HttpStatusCode?, _ dataDictionary: [String: Any]?) -> Void
    
    var task: URLSessionDataTask!
    var showError = true
    var showUpdatePopup = true
    var saveSuccessMessage = true
    
    init(successHandler: @escaping (T) -> Void,
         nullDataSuccessHandler: ((HttpStatusCode) -> Void)? = nil,
         errorHandler: @escaping (_ statusCode: HttpStatusCode?,
                                  _ dataDictionary: [String: Any]?) -> Void) {
        
        self.successHandler = successHandler
        self.nullDataSuccessHandler = nullDataSuccessHandler
        self.errorHandler = errorHandler
    }
    
    private func handleSucessResponse(data: T?) {
        guard let data = data else {
            guard let handler = self.nullDataSuccessHandler else {
                // MARK: Unknown Error Handler
                self.showErrorIfAllowed(error: NetworkError.genericError)
                self.errorHandler(nil, nil)
                return
            }
            handler(HttpStatusCode.success)
            return
        }
        // MARK: Success From Server
        self.successHandler(data)
    }
}

/*========================================================================*/
extension ApiManager {
    
    @discardableResult func makeNetworkCall(uploadRequest: UploadRequest? = nil,
                                            for method: ApiEndPoints? = nil,
                                            endPointUrl: String? = nil,
                                            with parameter: [String: Any]? = nil,
                                            requestType: Alamofire.HTTPMethod,
                                            showUpdatePopup: Bool = true,
                                            withLoader isLoader: Bool = false,
                                            showErrorMessages: Bool = true,
                                            saveSuccessMessage: Bool = true,
                                            baseUrlVersion: BaseUrlVersion = .version1) -> URLSessionDataTask? {
        
        self.showError = showErrorMessages
        self.saveSuccessMessage = saveSuccessMessage
        self.showUpdatePopup = showUpdatePopup
        
        guard let uploadRequest = uploadRequest else {
            
            let baseUrl = NETWORKCONSTANTS.getBaseUrl(with: baseUrlVersion)
            
            var url = String()
            
            if let endPointName = method {
                url = baseUrl + endPointName.methodName
            } else if let endPointUrl = endPointUrl {
                url = endPointUrl
            }
            print(url)
            
            self.makeRequestWithAlmofire(url: url, with: parameter, requestType: requestType)
            
            return nil
        }
        
        makeUploadRequestWithAlmofire(request: uploadRequest)
        return nil
    }
}

extension ApiManager {
    
    private func makeRequestWithAlmofire(url: String,
                                         with parameter: [String: Any]? = nil,
                                         requestType: Alamofire.HTTPMethod) {
		
        let header = HTTPHeaders(getApiHeaders())
        
        let encoding: ParameterEncoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        
        let request = AF.request(url, method: requestType, parameters: parameter, encoding: encoding, headers: header)
		// initialize timer 
		let startDate = Date()
        
        request.responseDecodable(of: ApiResponse<T>.self) { response in
            
			let executionTime = Date().timeIntervalSince(startDate)
            print("URL Response Time: \(executionTime) with url \(url)")
            self.handleAlmoFireResponse(response)
        }
    }
    
    private func makeUploadRequestWithAlmofire(request: UploadRequest) {
        request.responseDecodable(of: ApiResponse<T>.self) { response in
            self.handleAlmoFireResponse(response)
        }
    }
}

/*========================================================================*/
extension ApiManager {
    
    private func handleAlmoFireResponse(_ response: DataResponse<ApiResponse<T>, AFError>) {
    
        switch response.result {
        case .success(let serverResponse):
            
            if let data = response.data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("FOR DEBUGGING RAW JSON REPONSE")
                    print(jsonString)
                    // We can check update available from here
                }
            }
            
            guard let statusCode = serverResponse.okCode?.status else {
                // MARK: Unknown Error HandlerInt+Extensions.swift
                self.showErrorIfAllowed(error: NetworkError.genericError)
                self.errorHandler(nil, nil)
                return
            }
            switch statusCode {
            case .success:
                self.saveSuccessMessage ? lastServerSucessMessage = serverResponse.message : ()
                self.handleSucessResponse(data: serverResponse.data)
            case .validation:
                print(serverResponse.message ?? "")
                print(serverResponse.errors ?? [])
                showServerError(with: "", message: serverResponse.message ?? "")

                self.errorHandler(nil, nil)
            // MARK: Server Validation Errors
            case .unauthorized:
                // MARK: Unauthorized User
                self.errorHandler(nil, nil)
                self.logoutUser()
            case .failure:
                // MARK: Unknown Error Handler
                self.showErrorIfAllowed(error: NetworkError.genericError)
                self.errorHandler(nil, nil)
            case .serverError:
                break
            case .unknown:
                break
            }
            
        case .failure(let error):
            print(error)
            print(error.errorDescription ?? "")
            print(error.failureReason ?? "")
            
            // MARK: Unknown Error Handler
            isInternetAvailable() ? self.showErrorIfAllowed(error: NetworkError.genericError) : showNoInternetPopUp()
            self.errorHandler(nil, nil)
        }
    }
}
