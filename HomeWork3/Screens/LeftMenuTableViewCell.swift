//
//  LeftMenuTableViewCell.swift
//  HomeWork3
//
//  Created by Nguyễn Trung on 12/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var category: Category? {
        didSet {
            if let category = category {
                iconImageView.image = UIImage(named: category.image)
                contentLabel.text = category.name
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
//        iconImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        iconImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
