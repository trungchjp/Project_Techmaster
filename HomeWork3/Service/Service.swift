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
    
    private let defaults = UserDefaults.standard
    
    func loginUser(phone: String, password: String, completion: @escaping (_ Success: Bool )->()) {
        let params = [
            "phone": "\(phone)",
            "password": "\(password)"
        ]

        AF.request(URL_LOGIN, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: AFDataResponse<ProfileResult>) in
            if response.error == nil {
                let profileResponse = response.value
                if profileResponse?.code == 0 {
                    if let res = profileResponse?.datas {
                        completion(true)
                        UserDefaults.standard.set(res.token, forKey: "token")
                    }
                }
                else{
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
}

class RegisterService {
    
    static let register = RegisterService()
    
    func registerUser(name: String, phone: String, password: String, completion: @escaping (_ Success: Bool )->()) {
        let params = [
            "name": "\(name)",
            "phone": "\(phone)",
            "password": "\(password)"
        ]
        
        AF.request(URL_REGISTER, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: AFDataResponse<ProfileResult>) in
            if response.error == nil {
                let profileResponse = response.value
                if (profileResponse?.datas) != nil {
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}

class LoadIssuesService {
    
    static let issues = LoadIssuesService()
    
    func loadIssues1(completion: @escaping (_ arrProfile: [IssueDataDetail] )->()) {
    
        let header = [
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? "",
            "Content-Type": "application/json"
        ]
        
        AF.request(URL_ISSUES1, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.init(header)).responseObject { (response: AFDataResponse<IssueResult>) in
            let personResponse = response.value
            if let res = personResponse?.datas?.issues {
                completion(res)
            }
        }
    }
    
    func loadIssues2(completion: @escaping (_ arrProfile: [IssueDataDetail] )->()) {
    
        let header = [
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? "",
            "Content-Type": "application/json"
        ]
        
        AF.request(URL_ISSUES2, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.init(header)).responseObject { (response: AFDataResponse<IssueResult>) in
            let personResponse = response.value
            if let res = personResponse?.datas?.issues {
                completion(res)
            }
        }
    }
    
}

class ProfileService {
    
    static let profile = ProfileService()
    
    func loadProfile(completion: @escaping (_ arrProfile: ProfileData )->()) {
        
        let header = [
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? "",
            "Content-Type": "application/json"
        ]

        AF.request(URL_PROFILE, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.init(header)).responseObject { (response: AFDataResponse<Profile>) in
            let personResponse = response.value
            if let res = personResponse?.datas {
                completion(res)
            }
        }
    }
}

class UpdateProfileService {
    
    static let update = UpdateProfileService()
    
    func updateProfile(name: String, address: String, phone: String, avatar: String, completion: @escaping (_ Success: Bool )->()) {
        
        let header = [
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? ""
        ]
        
        let params = [
            "name": "\(name)",
            "address": "\(address)",
            "phone": "\(phone)",
            "avatar": "\(avatar)"
        ]
        
        AF.request(URL_UPDATE, method: .put, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders.init(header)).responseObject { (response: AFDataResponse<Profile>) in
            if response.error == nil {
                let profileResponse = response.value
                if profileResponse != nil{
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}

class CreateIssueService {
    
    static let create = CreateIssueService()
    
    func createIssue(title: String, content: String, address: String, media: String, completion: @escaping (_ Success: Bool )->()) {
        
        let header = [
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? ""
        ]
        
        let params: [String: Any] = [
          "title": "\(title)",
          "content": "\(content)",
          "address": "\(address)",
          "status": "Chưa xử lý",
          "media": ["\(media)"]
        ]
        
        AF.request(URL_CREATEISSUE, method: .post, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders.init(header)).responseObject { (response: AFDataResponse<IssueResult>) in
            if response.error == nil {
                let profileResponse = response.value
                if profileResponse != nil{
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
}
