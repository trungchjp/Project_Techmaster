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

let URL_REGISTER = URL_BASE + "/register"

let URL_LOGIN = URL_BASE + "/login"

let URL_UPDATE = URL_BASE + "/update-profile"

let URL_PROFILE = URL_BASE + "/profile"

let URL_ISSUES1 = URL_BASE + "/issues?status=0&keyword="

let URL_ISSUES2 = URL_BASE + "/issues?status=2&keyword="

let URL_CREATEISSUE = URL_BASE + "/create-issue"

let URL_UPLOADIMAGE = URL_BASE + "/upload-file"
