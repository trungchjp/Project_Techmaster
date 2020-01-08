//
//  ListIssueTableViewCell.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/9/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class ListIssueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var content: ContentIssue? {
        didSet {
            if let content = content {
                titleLabel.text = content.title
                timeLabel.text = content.time
                dateLabel.text = content.date
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
