//
//  Issues.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import ObjectMapper

class IssueResult: Mappable {
    var responseTime = ""
    var code = 0
    var message = ""
    var datas: IssueData?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        responseTime <- map["responseTime"]
        code <- map["code"]
        message <- map["message"]
        datas <- map["data"]
    }
}

class IssueData: Mappable {
    var issues = [IssueDataDetail]()
    var issuecount = 0

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        issues <- map["result"]
        issuecount <- map["issuecount"]
    }
}



class IssueDataDetail: Mappable {
    var id = 0
    var titleissue = ""
    var content = ""
    var addressissue = ""
    var timeissue = ""
    var dateissue = ""
    var statusissue = ""
    var mediaissue = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        titleissue <- map["title"]
        content <- map["content"]
        addressissue <- map["address"]
        timeissue <- map["time"]
        dateissue <- map["date"]
        statusissue <- map["status"]
        mediaissue <- map["media"]
    }
}
