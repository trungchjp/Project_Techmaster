//
//  ResponseLogin.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/4/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileResult: Mappable {
    var responseTime = ""
    var code = 0
    var message = ""
    var datas: UserData?

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

class UserData: Mappable {
    var userType = 0
    var userProfile: UserProfile?
    var token = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        userType <- map["userType"]
        userProfile <- map["userProfile"]
        token <- map["token"]
    }
}

class UserProfile: Mappable {
    var id = ""
    var name = ""
    var phone = ""
    var password = ""
    var avatar = ""
    var role = 0
    var address = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        password <- map["password"]
        avatar <- map["avatar"]
        role <- map["role"]
        address <- map["address"]
    }
}
