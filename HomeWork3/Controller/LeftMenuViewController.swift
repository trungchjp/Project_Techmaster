//
//  LeftMenuViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit
import Kingfisher

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    var profile = ProfileData()
    
    var datas = [Category]()
    
    let items = ["Báo cáo sự cố", "Danh sách sự cố", "Hồ sơ", "Cài đặt", "Đăng xuất"]
    
    let icons = ["icon1", "icon2", "icon3", "icon4", "icon5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width/2
        
        tableView.register(UINib(nibName: "LeftMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftMenuTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        ProfileService.profile.loadProfile { (entity) in
            self.profile = entity
            self.nameLabel.text = self.profile.name
            self.phoneLabel.text = self.profile.phone
            self.avatarImageView.setImage(self.profile.avatar)
        }
        
    }
    
    func confirm() {
        let alert = UIAlertController(title: "Bạn có chắc chắn muốn đăng xuất ?", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            self.resetDefaults()
            LogoutUser.updateRootVC()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion:  nil)
    }
    
    func moveSlide() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
    }
    

}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell", for: indexPath) as? LeftMenuTableViewCell {
            cell.contentLabel.text = items[indexPath.row]
            cell.iconImageView.image = UIImage(named: icons[indexPath.row])
            return cell
        }
        return UITableViewCell()
//        cell.category = Category[indexPath.row]
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = items[indexPath.row]
        
        switch name {
        case "Báo cáo sự cố":
            
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ReportViewController") as! ReportViewController
            let navigation = UINavigationController(rootViewController: mainVC)
            self.slideMenuController()?.changeMainViewController(navigation, close: true)
            
        case "Danh sách sự cố":
            
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ListIssueViewController") as! ListIssueViewController
            let navigation = UINavigationController(rootViewController: mainVC)
            self.slideMenuController()?.changeMainViewController(navigation, close: true)
            
        case "Hồ sơ":
            
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UpdateViewController") as! UpdateViewController
            let navigation = UINavigationController(rootViewController: mainVC)
            mainVC.onUpdateUser = { [weak self] name,phone,image in
                self?.avatarImageView.image = image
                self?.nameLabel.text = name
                self?.phoneLabel.text = phone
            }
            self.slideMenuController()?.changeMainViewController(navigation, close: true)
            
        case "Cài đặt":

            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingViewController") as! SettingViewController
            let navigation = UINavigationController(rootViewController: mainVC)
            self.slideMenuController()?.changeMainViewController(navigation, close: true)
        case "Đăng xuất":
            self.confirm()
            print("Đăng xuất")
        default:
            let listVC = ListIssueViewController()
            let navigation = UINavigationController(rootViewController: listVC)
            self.slideMenuController()?.changeMainViewController(navigation, close: true)
        }
    }
    
    func resetDefaults() {
        UserDefaults.standard.removeObject(forKey: "token")
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIImageView {
    
    func setImage(_ url: String) {
        let urlString = "\(URL_BASE)\(url)"
        if let url2 = URL(string: urlString){
            let placeholder = UIImage(named: "avatar")
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url2,placeholder: placeholder)
        }
    }
}
