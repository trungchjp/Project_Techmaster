//
//  AppDelegate.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 11/25/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

@UIApplicationMain
@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared = UIApplication.shared.delegate as? AppDelegate

    let status = UserDefaults.standard.string(forKey: "status")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *){
            
        }else{
            window = UIWindow(frame: UIScreen.main.bounds)
            let token = UserDefaults.standard.string(forKey: "token") ?? ""

            if token.isEmpty {
                startLogIn()
            }else{
                startMain()
            }
            
            window = UIWindow(frame: UIScreen.main.bounds)
                if( status != nil ){
                    let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListIssueViewController") as! ListIssueViewController
                    let leftVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuViewController") as! LeftMenuViewController
                    let navigation = UINavigationController(rootViewController: listVC)
                    navigation.modalPresentationStyle = .overFullScreen
                    let slideMenuController = SlideMenuController(mainViewController: navigation, leftMenuViewController: leftVC)
                    SlideMenuOptions.hideStatusBar = false
                    window?.rootViewController = slideMenuController
                    }
                else{
                    window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                    }
                window?.makeKeyAndVisible()
            
        }
        return true
    }
    
    func startLogIn(){
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }
    
    func startMain(){
        let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListIssueViewController") as! ListIssueViewController
        let slideVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuViewController") as! LeftMenuViewController
        let navigation = UINavigationController(rootViewController: listVC)
        navigation.modalPresentationStyle = .overFullScreen
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let slideMenuController = SlideMenuController(mainViewController: navigation, leftMenuViewController: slideVC)
        SlideMenuOptions.contentViewScale = 1
        window?.rootViewController = slideMenuController
        window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

