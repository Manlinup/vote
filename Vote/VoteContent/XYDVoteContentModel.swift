//
//  XYDVoteContentModel.swift
//  Vote
//
//  Created by 伟大航路 on 2018/1/22.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

class XYDVoteOptionModel: NSObject {
    var optionTitle: String?
}

class XYDVoteContentModel: NSObject {
    var title: String?
    var options = Array<XYDVoteOptionModel>()
}


