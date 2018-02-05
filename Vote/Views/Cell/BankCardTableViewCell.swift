//
//  BankCardTableViewCell.swift
//  Vote
//
//  Created by mc on 2017/12/10.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class BankCardTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var bankname: UILabel!

    @IBOutlet weak var cardtype: UILabel!
    
    @IBOutlet weak var cardmunber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
