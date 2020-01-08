//
//  LoadImage.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/9/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit
enum MimeType: String{
    case image = "image/jpeg"
}

class ApiManager {
    
    static let loadImage = ApiManager()
    
    func upload(image: UIImage, success: @escaping (String)->(), failure: @escaping (String)->()){
        let header = [
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? ""
        ]
        
        // tạo một hàm body request
        func createBody(boundary: String,
                        data: Data,
                        mimeType: MimeType,
                        filename: String) -> Data {
            let body = NSMutableData()
            
            let boundaryPrefix = "--\(boundary)\r\n"
            
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"fileData\"; filename=\"\(filename)\"\r\n")
            body.appendString("Content-Type: \(mimeType.rawValue)\r\n\r\n")
            body.append(data)
            body.appendString("\r\n")
            body.appendString("--".appending(boundary.appending("--")))
            
            return body as Data
        }
        
        guard let url2 = URL.init(string: URL_UPLOADIMAGE) else {
            return
        }
        
        // url
        var request  = URLRequest(url: url2)
        
        // method
        request.httpMethod = "POST"
        
        //
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // header
        request.allHTTPHeaderFields = header
        
        // truyền dữ liệu vào body
        request.httpBody = createBody(boundary: boundary,
                                      data: image.jpegData(compressionQuality: 0.2)!,
                                      mimeType: .image,
                                      filename: "quynhtao")
        
        // tạo một dataTask, với nhiệm vụ là gửi request, dữ liệu trả về là data, response và error
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            // SafeDispatch để gọi hàm trở lại foreground sau khi xử lý request
            DispatchQueue(label: URL_UPLOADIMAGE, qos: .background, attributes: .concurrent).async(execute: {
                if error == nil{
                    print("response \(response ?? URLResponse.init())")
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                            print("json \(json)")
                            
                            // đọc dữ liệu từ json
                            if let code = json["code"] as? Int, let url = json["data"] as? String, code == 0, !url.isEmpty{
                                success(url)
                            }else{
                                failure(json["message"] as? String ?? "")
                            }
                        }else{
                            failure("error")
                        }
                    }catch{
                        failure(error.localizedDescription)
                    }
                }else{
                    failure(error!.localizedDescription)
                }
            })
        })
        
        // gọi resume để chạy hàm dataTask
        dataTask.resume()
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
