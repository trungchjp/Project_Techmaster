//
//  LoadIssuesService.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class LoadIssuesService {
    
    static let issues = LoadIssuesService()
    
    func loadIssues(completion: @escaping (_ arrProfile: [IssueDataDetail] )->()) {
        
        let url = "http://45.118.145.149:8100/issues?status=-1&keyword="
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders.init(BEARER_HEADER)).responseObject { (response: AFDataResponse<IssueResult>) in
            let personResponse = response.value
            if let res = personResponse?.datas?.issues {
                completion(res)
            }
        }
    }
}
