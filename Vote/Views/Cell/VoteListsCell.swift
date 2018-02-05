//
//  VoteListsCell.swift
//  Vote
//
//  Created by 林以达 on 2017/11/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class VoteListsCell: UITableViewCell {
    @IBOutlet weak var voteTitle: UILabel!
    @IBOutlet weak var voteTime: UILabel!
    @IBOutlet weak var votePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
