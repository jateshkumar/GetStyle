//
//  Shortcuts.swift
//  Orko
//
//  Created by Jatesh Kumar Maheshwari on 15/08/2022.
//

import Foundation
import UIKit
import SystemConfiguration

//let DJM = DynamicJSONManager.shared
var lastServerSucessMessage: String?

func printGetStyle(_ any: Any) {
    let type = getEnvType()
    if type == .dev || type == .qa || type == .stage {
        print(any)
    }
}

func getFont(of size: CGFloat) -> UIFont? {
    return UIFont(name: "", size: size)
}

func getDeviceSizeDetails() -> CGRect {
    return UIScreen.main.bounds
}

func getApiHeaders() -> [String: String] {
    
    var headers = [String: String]()
    headers["x-device-type"] = "ios"
    headers["x-device-brand"] = "apple"
    headers["x-os-version"] = "\(UIDevice.current.systemVersion)"
    headers["x-app-version"] = appVersionWithBuilNumber()
    headers["Content-Type"] = "application/json"
    headers["Domain"] = "Orko"
    
//    if let token = UserDefaults.authenticationToken {
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjk0MjYzMDcxLCJpYXQiOjE2NjI3MjcwNzEsImp0aSI6ImM5NGMxZDZjODJkMzQyZjA4Y2VmMDIzZGJhMzQyYThlIiwidXNlcl9pZCI6NDR9.YJRDu81IJPHa6Q5Y7fvz--gVMZXRtU0gN3cOdMT40vE"
        print("Token is: Bearer \(token)")
        !token.isEmpty ? (headers["Authorization"] = "Bearer \(token)") : ()
//    }
    
    return headers
}

func getEnvType() -> EnvType {
    #if DEV
    return .dev
    #elseif QA
    return .qa
    #elseif STAGE
    return .stage
    #else
    return .release
    #endif
}

func isInternetAvailable() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

func appVersionWithBuilNumber() -> String {
    guard let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
          let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
        return "0.0"
    }
    return "\(shortVersion).\(build)"
}

func showServerError(with title: String, message: String) {
    InformativeAlertManager().serverErrors(title: title, message: message)
}

func showNoInternetPopUp() {
    InformativeAlertManager().noInternetConnectionPopUp()
}

// MARK: PARSING VALIDATION ERROR
func parseFailedResponse(_ dataDictionary: [String: Any]?) -> (message: String?, details: String?) {
    
    guard let dataDictionary = dataDictionary else {
        return (nil, nil)
    }
    
    var errorMessage: String?
    var errorDetails: String?
    
    if let message = dataDictionary["message"] as? String {
        errorMessage = message
    }
    
    if let error = dataDictionary["errors"] as? [String] {
        errorDetails = error.joined(separator: "\n")
    }
    
    return (errorMessage, errorDetails)
}

func parseAndShowFailureMessage(_ dataDictionary: [String: Any]?) {
    let error = parseFailedResponse(dataDictionary)
    if let msg = error.message {
        showServerError(with: msg, message: error.details ?? "")
    }
}

func verifyUrl (urlString: String?) -> URL? {
    
    guard let urlString = urlString,
          let stringUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: stringUrl),
          UIApplication.shared.canOpenURL(url) else {
        return nil
    }
    return url
}

//func openModuleOnFullScreen(controller: UIViewController) {
//    let nav = UINavigationController(rootViewController: controller)
//    nav.modalPresentationStyle = .fullScreen
//    UIViewController.top().present(nav, animated: true, completion: nil)
//}
func openModuleOnNavigation(from: UIViewController?, controller: UIViewController?) {
    guard let cFrom = from, let cTo = controller else { return  }
    cFrom.navigationController?.pushViewController(cTo, animated: true)
}

func makePhoneCall(number: String?) {
    guard let numberS = number,
        let phoneNumber = URL(string: "tel://" + numberS) else { return }
    UIApplication.shared.open(phoneNumber)
}

func formateDate(date: String, previousFormat: String?, newFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = previousFormat
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = newFormat
    return dateFormatter.string(from: date ?? Date())
}

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
