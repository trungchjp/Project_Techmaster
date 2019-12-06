//
//  Profile.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import ObjectMapper

class Profile: Mappable {
    var responseTime = ""
    var code = 0
    var message = ""
    var datas: ProfileData?

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

class ProfileData: Mappable {
    var id = 0
    var name = ""
    var phone = ""
    var password = ""
    var avatar = ""
    var address = ""
    var role = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        password <- map["password"]
        avatar <- map["avatar"]
        address <- map["address"]
        role <- map["role"]
    }
}
