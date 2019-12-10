//
//  LoginViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class LoginViewController: UIViewController {
    
    var window: UIWindow?
    
    static let login = LoginViewController()
    
    let contentView: UIView = {
        let view = UIView()
        //        view.backgroundColor = .red
        return view
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
        imageView.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Số điện thoại"
        textField.borderStyle = .none
        textField.textAlignment = .center
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mật khẩu"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Đăng nhập", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.brown.cgColor
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Đăng ký", for: .normal)
        button.setTitleColor(UIColor.brown, for: .normal)
//        button.backgroundColor = .green
        return button
    }()
    
    let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Chưa có tài khoản?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    
    deinit {
        print("Huỷ AlamofireObjectMapper")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubview()
        setupLayout()
        config()
        
        
        
        registerButton.addTarget(self, action: #selector(handRegister), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handLogin), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        phoneTextField.underlined(.gray)
        passwordTextField.underlined(.gray)
    }
    
    @objc func handRegister() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        self.present(mainVC, animated: true, completion: nil)
    }
    
    func alertLogin (title: String) {

        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func handLogin() {
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            alertLogin(title: "Chưa nhập số điện thoại")
        return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            alertLogin(title: "Chưa nhập mật khẩu")
        return
        }
        LoginService.instance.loginUser(phone: phone, password: password) { (success) in
            if success {
                let listVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListIssueViewController") as! ListIssueViewController
                let leftVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuViewController") as! LeftMenuViewController
                let navigation = UINavigationController(rootViewController: listVC)
                let slideMenuController = SlideMenuController(mainViewController: navigation, leftMenuViewController: leftVC)
                slideMenuController.modalPresentationStyle = .overFullScreen
//                self.window?.rootViewController = slideMenuController
//                self.window?.makeKeyAndVisible()
                self.present(slideMenuController, animated: true, completion: nil)
                print("Đăng nhập thành công!!!")
            } else {
                self.alertLogin(title: "Tài khoản không tồn tại")
            }
        }
    }
    
    func addSubview(){
        view.addSubview(contentView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        contentView.addSubview(registerButton)
        contentView.addSubview(noteLabel)
    }
    
    func setupLayout(){
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).offset(0)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            
            make.centerX.equalTo(view.center.x)
            make.size.equalTo(CGSize(width: self.view.frame.size.height/3 * 2, height: 200))
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom).offset(64)
            make.left.equalTo(view.snp.left).offset(64)
            make.right.equalTo(contentView).offset(-64)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(16)
            make.left.equalTo(phoneTextField.snp.left).offset(0)
            make.right.equalTo(phoneTextField.snp.right).offset(0)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.left.equalTo(passwordTextField.snp.left).offset(0)
            make.right.equalTo(passwordTextField.snp.right).offset(0)
            make.height.equalTo(40)
        }
        
        noteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.left.equalTo(loginButton.snp.left).offset(0)
            make.height.equalTo(30)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(noteLabel.snp.top).offset(0)
            make.right.equalTo(loginButton.snp.right).offset(0)
            make.height.equalTo(30)
            make.left.equalTo(noteLabel.snp.right).offset(4)
        }
        
    }
    
    
    
    func config(){
        let phoneIconImageView = UIImageView(image: UIImage(named: "phoneIcon"))
        phoneIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: phoneIconImageView.image!.size.width + 10, height: phoneIconImageView.image!.size.height)
        phoneIconImageView.contentMode = .center
        
        phoneTextField.leftView = phoneIconImageView
        phoneTextField.leftViewMode = .always
        
        let passwordIconImageView = UIImageView(image: UIImage(named: "keyIcon"))
        passwordIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: passwordIconImageView.image!.size.width + 10, height: passwordIconImageView.image!.size.height)
        passwordIconImageView.contentMode = .center
        
        passwordTextField.leftView = passwordIconImageView
        passwordTextField.leftViewMode = .always
        
    }
    
}

extension UITextField {
    
    func underlined(_ color: UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
