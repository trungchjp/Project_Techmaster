//
//  UpdateViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit
import Photos

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!

    var avatar: String?
    var profile = ProfileData()
    var imagePicker: UIImagePickerController!
    var onUpdateUser: ((String, String, UIImage?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        avatarImageView.setImage(self.profile.avatar)
        avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width/2

        nameTextField.underlined(.gray)
        phoneTextField.underlined(.gray)
        adressTextField.underlined(.gray)
        
        addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
        navigationItem.title = "Hồ sơ"
        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cập nhật", style: .done, target: self, action: #selector(update))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        ProfileService.profile.loadProfile { (entity) in
            self.profile = entity
            self.nameTextField.text = self.profile.name
            self.phoneTextField.text = self.profile.phone
            self.adressTextField.text = self.profile.address
            self.avatarImageView.setImage(self.profile.avatar)
            self.avatar = self.profile.avatar
        }
    }
    
    @objc func update() {
        guard let name = nameTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let address = adressTextField.text else { return }
        UpdateProfileService.update.updateProfile(name: name, address: address, phone: phone, avatar: avatar ?? "") { (success) in
            if success {
                self.slideMenuController()?.toggleLeft()
                self.onUpdateUser?(name, phone, self.avatarImageView.image)
                print("Cập nhật thành công!!!")
            } else {
                print("Cập nhật thất bại!!!")
            }
        }
    }
    
    @IBAction func changeAvatarButton(_ sender: Any) {
        let alert = UIAlertController(title: "Chọn ảnh từ", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Máy ảnh", style: .default, handler: { (_) in
            print("Chọn ảnh từ máy ảnh")
            self.fromCamera()
        })
        let libray = UIAlertAction(title: "Thư viện", style: .default, handler: { (_) in
            print("Chọn ảnh từ thư viện")
            self.fromLibrary()
        })
        
        alert.addAction(camera)
        alert.addAction(libray)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func confirm(message: String, viewController: UIViewController?, success: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        viewController?.present(alert, animated: true, completion:  nil)
    }
    
    func setting() {
        let message = "App cần truy cập máy ảnh và thư viện của bạn. Ảnh của bạn sẽ không được chia sẻ"
        confirm(message: message, viewController: self) {
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString)
                else { return}
            
            if UIApplication.shared.canOpenURL(settingUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.canOpenURL(settingUrl)
                } else {
                    UIApplication.shared.openURL(settingUrl)
                }
            }
        }
    }
    
    private func fromCamera() {
        func takePhoto() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.cameraDevice = .front
                self.imagePicker.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (response) in
            if response {
                takePhoto()
            } else {
                print("Camera denied")
                self.setting()
            }
        }
    }
    
    private func fromLibrary() {
        func choosePhoto() {
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.imagePicker.modalPresentationStyle = .popover
            DispatchQueue.main.async {
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        
        //khai báo để lấy quyền truy cập
        let status = PHPhotoLibrary.authorizationStatus()
            
        if (status == PHAuthorizationStatus.authorized) {
            //Quyền đã được cấp
            choosePhoto()
        } else if (status == PHAuthorizationStatus.denied) {
            //Quyền bị từ chối
            print("Photo denied")
            setting()
        } else if (status == PHAuthorizationStatus.notDetermined) {
            //Quyền truy cập chưa được xác nhận
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    choosePhoto()
                } else {
                    print("Không được cho phép truy cập vào thư viện")
                    self.setting()
                }
            }
        } else if (status == PHAuthorizationStatus.restricted) {
            //Truy cập bị hạn chế, thông thường sẽ không xảy ra
            print("Restricted access")
            setting()
        }
    }
    
}

extension UpdateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("error: \(info)")
            return
        }
        ApiManager.loadImage.upload(image: selectedImage, success: { (linkImage) in
            print("Lấy ảnh thành công")
            self.avatar = linkImage
        }) { (failure) in
            print("Lấy ảnh lỗi")
        }
        self.avatarImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

