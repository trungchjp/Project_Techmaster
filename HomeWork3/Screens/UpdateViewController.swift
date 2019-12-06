//
//  UpdateViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    var profile = ProfileData()

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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cập nhật", style: .done, target: self, action: #selector(update))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        ProfileService.profile.loadProfile { (entity) in
            self.profile = entity
            self.nameTextField.text = self.profile.name
            self.phoneTextField.text = self.profile.phone
            self.adressTextField.text = self.profile.address
        }
        
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
    
    @objc func update() {
        guard let name = nameTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let address = adressTextField.text else { return }
        UpdateProfileService.update.updateProfile(name: name, address: address, phone: phone, avatar: "") { (success) in
            if success {
                self.dismiss(animated: false, completion: nil)
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                self.view.window!.layer.add(transition, forKey: kCATransition)
                print("Cập nhật thành công!!!")
            }
        }
        
    }

}
