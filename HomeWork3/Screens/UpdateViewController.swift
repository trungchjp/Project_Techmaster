//
//  UpdateViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width/2

        nameTextField.underlined(.gray)
        phoneTextField.underlined(.gray)
        adressTextField.underlined(.gray)
        
        navigationItem.title = "Hồ sơ"

        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cập nhật", style: .done, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    }
    
    @objc func back() {
        dismiss(animated: false, completion: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
    }

}
