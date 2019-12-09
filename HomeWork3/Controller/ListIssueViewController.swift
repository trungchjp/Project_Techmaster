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
    
    var issues = [IssueDataDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
        
        tableView.register(UINib(nibName: "ListIssueTableViewCell", bundle: nil), forCellReuseIdentifier: "ListIssueTableViewCell")
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
        
        LoadIssuesService.issues.loadIssues1 { (issues) in
            self.issues = issues
            self.tableView.reloadData()
        }
        
    }
    
    @objc func search() {
        
    }
    
    @IBAction func optionSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            LoadIssuesService.issues.loadIssues1 { (issues) in
                self.issues = issues
                self.tableView.reloadData()
            }
        case 1:
            LoadIssuesService.issues.loadIssues2 { (issues) in
                self.issues = issues
                self.tableView.reloadData()
            }
        default:
            LoadIssuesService.issues.loadIssues1 { (issues) in
                self.issues = issues
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ListIssueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListIssueTableViewCell", for: indexPath) as! ListIssueTableViewCell
//        cell?.textLabel?.text = self.issues[indexPath.row].titleissue
        cell.titleLabel.text = issues[indexPath.row].titleissue
        cell.timeLabel.text = issues[indexPath.row].timeissue
        cell.dateLabel.text = issues[indexPath.row].dateissue
        return cell
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
