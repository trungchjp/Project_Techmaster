//
//  ViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 11/25/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let contentView:UIView = {
        let view = UIView()
        return view
    }()
    
    let bannerImageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "banner")
        view.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nameTextField:UITextField = {
        let view = UITextField()
        view.placeholder = "Họ và tên"
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let phoneTextField:UITextField = {
        let view = UITextField()
        view.placeholder = "Số điện thoại"
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let passwordTextField:UITextField = {
        let view = UITextField()
        view.placeholder = "Mật khẩu"
        view.borderStyle = .none
        view.textAlignment = .center
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
    }()
    
    let rePasswordTextField:UITextField = {
        let view = UITextField()
        view.placeholder = "Nhập lại mật khẩu"
        view.borderStyle = .none
        view.textAlignment = .center
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
    }()
    
    let registerButton:UIButton = {
        let view = UIButton()
        view.setTitle("Đăng kí", for: .normal)
        view.layer.cornerRadius = 5
        view.layer.backgroundColor = UIColor.brown.cgColor
        return view
    }()
    
    let loginButton:UIButton = {
        let view = UIButton()
        view.setTitle("Đăng nhập", for: .normal)
        view.setTitleColor(UIColor.brown, for: .normal)
        return view
    }()
    
    let notificationLabel:UILabel = {
        let view = UILabel()
        view.text = "Đã có tài khoản?"
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = .right
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupLayout()
        config()
        
        loginButton.addTarget(self, action: #selector(handLogin), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        phoneTextField.underlined(.gray)
        passwordTextField.underlined(.gray)
        nameTextField.underlined(.gray)
        rePasswordTextField.underlined(.gray)
    }
    
    @objc func handLogin() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.present(mainVC, animated: true, completion: nil)
    }

    func setupLayout() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).offset(0)
        }
        
        bannerImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(64)
            make.right.equalTo(contentView.snp.right).offset(0)
            make.left.equalTo(contentView.snp.left).offset(0)
            make.height.equalTo(200)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(bannerImageView.snp.bottom).offset(64)
            make.left.equalTo(bannerImageView.snp.left).offset(54)
            make.right.equalTo(bannerImageView.snp.right).offset(-64)
            make.height.equalTo(40)
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.equalTo(nameTextField.snp.leading)
            make.width.equalTo(nameTextField.snp.width)
            make.height.equalTo(nameTextField.snp.height)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(10)
            make.leading.equalTo(phoneTextField.snp.leading)
            make.width.equalTo(phoneTextField.snp.width)
            make.height.equalTo(phoneTextField.snp.height)
        }
        
        rePasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.width.equalTo(passwordTextField.snp.width)
            make.height.equalTo(passwordTextField.snp.height)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(rePasswordTextField.snp.bottom).offset(50)
            make.leading.equalTo(rePasswordTextField.snp.leading)
            make.width.equalTo(rePasswordTextField.snp.width)
            make.height.equalTo(rePasswordTextField.snp.height)
        }
        
        notificationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.bottom).offset(10)
            make.leading.equalTo(registerButton.snp.leading)
            make.height.equalTo(rePasswordTextField.snp.height)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(notificationLabel.snp.top)
            make.left.equalTo(notificationLabel.snp.right).offset(10)
            make.right.equalTo(registerButton.snp.right).offset(-30)
            make.height.equalTo(notificationLabel.snp.height)
        }
        
    }
    
    func addSubview() {
        view.addSubview(contentView)
        view.addSubview(bannerImageView)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rePasswordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(notificationLabel)
    }
    
    func config(){
        
            let nameIconImageView = UIImageView(image: UIImage(named: "nameIcon"))
            nameIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: 10, height: 10)
            nameIconImageView.contentMode = .center
        
            nameTextField.leftView = nameIconImageView
            nameTextField.leftViewMode = .always
            let phoneIconImageView = UIImageView(image: UIImage(named: "phoneIcon"))
            phoneIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: phoneIconImageView.image!.size.width, height: phoneIconImageView.image!.size.height)
            phoneIconImageView.contentMode = .center
            
            phoneTextField.leftView = phoneIconImageView
            phoneTextField.leftViewMode = .always
            
            let passwordIconImageView = UIImageView(image: UIImage(named: "keyIcon"))
            passwordIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: passwordIconImageView.image!.size.width, height: passwordIconImageView.image!.size.height)
            passwordIconImageView.contentMode = .center
        
            passwordTextField.leftView = passwordIconImageView
            passwordTextField.leftViewMode = .always
            
            let rePasswordIconImageView = UIImageView(image: UIImage(named: "keyIcon"))
            rePasswordIconImageView.frame = CGRect(x: 0.0, y: 0.0, width: rePasswordIconImageView.image!.size.width, height: rePasswordIconImageView.image!.size.height)
            rePasswordIconImageView.contentMode = .center
            
            rePasswordTextField.leftView = rePasswordIconImageView
            rePasswordTextField.leftViewMode = .always
        
    }
    

}


