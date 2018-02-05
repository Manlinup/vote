//
//  PutListCell.swift
//  Vote
//
//  Created by 林以达 on 2017/11/16.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class PutListCell: UITableViewCell {

    //MARK: Properties

    
    @IBOutlet weak var topictitle: UILabel!//题目标题
    
    @IBOutlet weak var topictype: UILabel!//题目类型
    var radio: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
