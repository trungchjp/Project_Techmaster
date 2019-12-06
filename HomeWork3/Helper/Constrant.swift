//
//  Constrant.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/6/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation

import UIKit
typealias CompletionHandler = (_ Success: Bool) -> ()

let URL_BASE = "http://45.118.145.149:8100"

let URL_REGISTER = URL_BASE+"/register"

let URL_LOGIN = URL_BASE+"/login"

let TOKEN_KEY = "token"

let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
    
]

let BEARER_HEADER = [
    "Authorization":"\(LoginService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
