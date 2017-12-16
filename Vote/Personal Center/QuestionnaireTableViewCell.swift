//
//  QuestionnaireTableViewCell.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class QuestionnaireTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var schedule: UILabel!
    @IBOutlet weak var styleone: UILabel!
    @IBOutlet weak var styletwo: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
