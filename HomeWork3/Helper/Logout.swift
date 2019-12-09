//
//  Logout.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/8/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

class LogoutUser {
    static func updateRootVC(){
            let status = UserDefaults.standard.string(forKey: "status")
            var rootVC : UIViewController?
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListIssueViewController") as! ListIssueViewController

            if(status != nil ){
                let slideVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuViewController") as! LeftMenuViewController
                let navigation = UINavigationController(rootViewController: mainVC)
                let slideMenuController = SlideMenuController(mainViewController: navigation, leftMenuViewController: slideVC)
                SlideMenuOptions.hideStatusBar = false
                rootVC = slideMenuController
            }else{
                rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController

            }

            UIApplication.shared.keyWindow?.rootViewController = rootVC;
        }
}
