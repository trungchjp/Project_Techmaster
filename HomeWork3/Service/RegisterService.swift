//
//  RegisterService.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegisterService {
    
    static let register = RegisterService()
    
    func registerUser(name: String, phone: String, password: String, completion: @escaping (_ Success: Bool )->()) {
        let params = [
            "name": "\(name)",
            "phone": "\(phone)",
            "password": "\(password)"
        ]
        
        AF.request(URL_REGISTER, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: AFDataResponse<ProfileResult>) in
            print(name, phone, password)
            if response.error == nil {
                let profileResponse = response.value
                if let res = profileResponse?.datas {
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}
