//
//  BaseViewController.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/5.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.vtViewBackgroundColor()
        
        self.view = view
    }
}
