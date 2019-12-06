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
    
    let defaults = UserDefaults.standard
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    func loginUser(phone: String, password: String, completion: @escaping (_ Success: Bool )->()) {
        let params = [
            "phone": "\(phone)",
            "password": "\(password)"
        ]

        AF.request(URL_LOGIN, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: AFDataResponse<ProfileResult>) in
            print(phone, password)
            if response.error == nil {
                let profileResponse = response.value
                if profileResponse?.code == 0 {
                    if let res = profileResponse?.datas {
                        print(res.token)
                        completion(true)
                        guard let token = profileResponse?.datas?.token else {return}
                        self.authToken = token
//                        UserDefaults.standard.set(res.token, forKey: "token")
                    }
                }
                else{
                    print(profileResponse?.message)
                }
            } else {
                completion(false)
            }
        }
    }
}
