//
//  ProfileService.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class ProfileService {
    
    static let profile = ProfileService()
    
    func loadProfile(completion: @escaping (_ arrProfile: ProfileData )->()) {
        
        let url = "http://45.118.145.149:8100/profile"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.init(BEARER_HEADER)).responseObject { (response: AFDataResponse<Profile>) in
            let personResponse = response.value
            if let res = personResponse?.datas {
                completion(res)
            }
        }
    }
}

