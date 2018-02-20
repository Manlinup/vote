//
//  SelectedTypeViewController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/21.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class SelectedTypeController: UIViewController {
    let udname = UserDefaultsKey.SelectedTopicsType()//获取UserDefaults名称
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //保存数据到本地
    let defaults = UserDefaults.standard
    var optiontype = 0
    @IBAction func selectedtype(_ sender: UIButton) {
       //tag值/单选1001/多选1002
        switch sender.tag {
        case 1001:
            optiontype = 1001
            defaults.set(optiontype, forKey: udname.optiontype)
            performSegue(withIdentifier: "MultipleChoice", sender: self)
        case 1002:
            optiontype = 1002
            defaults.set(optiontype, forKey: udname.optiontype)
           performSegue(withIdentifier: "MultipleChoice", sender: self)
        default:break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
