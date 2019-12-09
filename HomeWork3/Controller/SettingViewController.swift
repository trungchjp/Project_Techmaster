//
//  SettingViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/5/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)

        navigationItem.title = "Cài đặt"

        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
}
