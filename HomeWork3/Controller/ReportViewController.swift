//
//  ReportViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/5/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adressTextField.underlined(.gray)
        titleTextField.underlined(.gray)
        contentTextField.underlined(.gray)
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)

        navigationItem.title = "Báo cáo sự cố"

        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Gửi", style: .done, target: self, action: #selector(send))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
                
    }
    
    @objc func send() {
        
    }
}
