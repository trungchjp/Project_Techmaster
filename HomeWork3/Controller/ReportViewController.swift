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

        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Gửi", style: .done, target: self, action: #selector(send))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
                
    }
    
    @objc func send() {
        guard let title = titleTextField.text else { return }
        guard let address = adressTextField.text else { return }
        guard let content = contentTextField.text else { return }
        CreateIssueService.create.createIssue(title: title, content: content, address: address, media: "") { (success) in
            if success {
                let alert = UIAlertController(title: "Cảm ơn bạn đã gửi báo cáo. Chúng tôi sẽ giải quyết trong thời gian sớm nhất", message: "", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.slideMenuController()?.toggleLeft()
                }
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                print("Báo cáo sự cố thành công!!!")
            } else {
                print("Báo cáo sự cố không thành công!!!")
            }
        }
    }
}
