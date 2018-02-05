//
//  MyDraftTableViewCell.swift
//  Vote
//
//  Created by mc on 2017/12/19.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class MyDraftTableViewCell: UITableViewCell {

    
    @IBOutlet weak var style01: UIButton!//样式一
    @IBOutlet weak var style02: UILabel!//样式二
    @IBOutlet weak var draftstatus: UILabel!//草稿状态
    @IBOutlet weak var displaycontent: UILabel!//展示标题
    @IBOutlet weak var nownumber: UILabel!//现有数量
    @IBOutlet weak var maxnumber: UILabel!//上限数量
    @IBOutlet weak var draftitle: UILabel!//草稿标题
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
