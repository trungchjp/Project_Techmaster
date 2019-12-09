//
//  ListIssueViewController.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/4/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class ListIssueViewController: UIViewController {

    @IBOutlet weak var optionSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var issues = [IssueDataDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
//        self.slideMenuController()?.removeLeftGestures()
//        self.slideMenuController()?.addLeftGestures()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        navigationItem.title = "Danh sách sự cố"

        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(nextToLeft))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        getlist(index: 0)
        
        LoadIssuesService.issues.loadIssues { (issues) in
            self.issues = issues
            self.tableView.reloadData()
        }
        
    }
    
    @objc func search() {
        
    }
    
    var list1 = ["aaaa","cccc"]
    var list2 = ["bbbb","dddd"]
    var list:[String] = []
    
    
    func getlist(index: Int) {
        list = (index == 0) ? list1 : list2
    }
    
    @IBAction func optionSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            getlist(index: 1)
        case 1:
            getlist(index: 0)
        default:
            getlist(index: 0)
        }
    }
    
}

extension ListIssueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
//        cell?.textLabel?.text = list[indexPath.row]
        cell?.textLabel?.text = self.issues[indexPath.row].content
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailIssueViewController") as! DetailIssueViewController
        mainVC.info = issues[indexPath.row]
        let navigation = UINavigationController(rootViewController: mainVC)
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: false, completion: nil)
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
    }
    
}
