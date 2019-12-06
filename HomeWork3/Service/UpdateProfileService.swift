//
//  UpdateProfileService.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class UpdateProfileService {
    
    static let update = UpdateProfileService()
    
    func updateProfile(name: String, address: String, phone: String, avatar: String, completion: @escaping (_ Success: Bool )->()) {
        
        let params = [
            "name": "\(name)",
            "address": "\(address)",
            "phone": "\(phone)",
            "avatar": ""
        ]
        
        let url = "http://45.118.145.149:8100/update-profile"
        AF.request(url, method: .put, parameters: params, encoding: URLEncoding.default, headers: HTTPHeaders.init(BEARER_HEADER)).responseObject { (response: AFDataResponse<Profile>) in
            print(name, address, phone)
            if response.error == nil {
                let profileResponse = response.value
                if let res = profileResponse{
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}

