//
//  TestTableViewCell.swift
//  SwiftTest
//
//  Created by Guibin on 15/7/4.
//  Copyright (c) 2015年 Person. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var _headImg: UIImageView!
    
    @IBOutlet weak var _labName: UILabel!
    
    @IBOutlet weak var _labDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
