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
    
    static let instance = ListIssueViewController()
    
    var isState = ["no_process", "processing", "processed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        navigationItem.title = "Danh sách sự cố"
    
        navigationController?.navigationBar.barTintColor = UIColor.brown
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(nextToLeft))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        getlist(index: 0)
    }
    
    @objc func nextToLeft() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LeftMenuViewController") as! LeftMenuViewController
        self.present(mainVC, animated: true, completion: nil)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
    }
    
    @objc func search() {
        
    }
    
    @objc func add() {
        
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
            tableView.reloadData()
        }
        tableView.reloadData()
    }
    
}

extension ListIssueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = list[indexPath.row]
        cell?.detailTextLabel?.text = list[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailIssueViewController") as! DetailIssueViewController
        let navigation = UINavigationController(rootViewController: mainVC)
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: true, completion: nil)
        
    }
    
}
