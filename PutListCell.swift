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
    @IBOutlet weak var sortNum: UILabel!
    @IBOutlet weak var voteTitle: UITextField!
    
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
