//
//  Service.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/4/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService {
    
    static let instance = LoginService()
    
    func loginUser(phone: String, password: String, completion: @escaping (_ Success: Bool )->()) {
        let params = [
            "phone": "\(phone)",
            "password": "\(password)"
        ]
        let url = "http://45.118.145.149:8100/login"
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: AFDataResponse<ProfileResult>) in
            print(phone, password)
//            print(response.result)
            if response.error == nil {
                let profileResponse = response.value
                if let res = profileResponse?.datas {
                    print(res.token)
                    completion(true)
                    let token = profileResponse?.datas?.token
                    let userDefault = UserDefaults.standard
                    userDefault.set(token, forKey: "token")
                }
            } else {
                completion(false)
            }
        }
    }
}
