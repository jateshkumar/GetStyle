//
//  FileUploader.swift
//  NextGeni Network Layer
//  Created by Saad Ali Khan on 04/08/2022.
//  Copyright © 2022 Next Generation Innovation. All rights reserved.
//

//import Foundation
//
//struct MediaObject {
//    let keyName: String
//    let mediaFiles: [AttachmentModel]
//}
//
//class FileUploader {
//
//    func getUrlRequest(with params: [String: Any],
//                       filesToUpload: [MediaObject],
//                       endPoint: ApiEndPoints? = nil,
//                       endPointUrl: String? = nil ) -> URLRequest? {
//
//        let baseUrl = NETWORKCONSTANTS.getBaseUrl(with: .version1)
//
//        var url = String()
//
//        if let endPointName = endPoint {
//            url = baseUrl + endPointName.methodName
//        } else if let endPointUrl = endPointUrl {
//            url = endPointUrl
//        }
//
//        guard let requestUrl = URL(string: url) else {
//            return nil
//        }
//
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = getApiHeaders()
//
//        // Boundary generation and HTTP Body Creation
//        let boundary = generateBoundary()
//        request.setValue("multipart/form-data;boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let dataBody = createDataBody(withParameters: params,
//                                      media: filesToUpload,
//                                      boundary: boundary)
//        request.httpBody = dataBody
//
//        return request
//    }
//
//    private func createDataBody(withParameters params: [String: Any],
//                                media: [MediaObject],
//                                boundary: String) -> Data {
//        var body = Data()
//
//        let parameters = params
//        for (key, value) in parameters {
//            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
//            body.append("\(value)".data(using: .utf8)!)
//        }
//
//        media.forEach({
//
//            let key = $0.keyName
//            let files = $0.mediaFiles
//
//            let pdfFiles = files.filter { $0.type == .pdf }
//
//            pdfFiles.forEach {
//
//                if let pdf = $0.url,
//                    let pdfUrl = URL(string: pdf) {
//                    print(pdfUrl)
//                    do {
//                        let fileName = pdfUrl.lastPathComponent
//                        let pdfData = try Data.init(contentsOf: pdfUrl)
//                        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//                        body.append("Content-Disposition: form-data; name=\"\("\(key)")\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//                        body.append("Content-Type: pdf\r\n\r\n".data(using: .utf8)!)
//                        body.append(pdfData)
//                    } catch let error {
//                        print(error)
//                    }
//                }
//            }
//
//            let images = files.filter { $0.type == .image }
//
//            for (index, image) in images.enumerated() {
//                if let image = image.image,
//                    let imageCompressed = image.jpeg(.medium),
//                    let imageData = imageCompressed.jpegData(compressionQuality: 0.2) {
//                    body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"\("\(key)")\"; filename=\"\("\(index).jpg")\"\r\n".data(using: .utf8)!)
//                    body.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)
//                    body.append(imageData)
//                }
//            }
//        })
//
//        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//        return body
//    }
//
//    private func generateBoundary() -> String {
//        return "Boundary-\(NSUUID().uuidString)"
//    }
//}
