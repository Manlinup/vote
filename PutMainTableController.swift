//
//  PutMainTableController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/15.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class PutMainTableController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var num: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var days: UITextField!
    
    var voteAnswer: String?
    var voteNum: String?
    var votePrice: String?
    var voteFee: Int?
    var voteLength: String?
    var voteDays: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("启动")
        
        answer.delegate = self
        num.delegate = self
        price.delegate = self
        length.delegate = self
        days.delegate = self
        
        tableView.separatorColor = UIColor(white: 1, alpha: 0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == answer {
            textField.keyboardType = .default
        } else {
            textField.keyboardType = .numberPad
            textField.returnKeyType = .done
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //关闭键盘
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch textField {
        case answer:
            voteAnswer = newText
        case num:
            voteNum = newText
        case price:
            votePrice = newText
        case length:
            voteLength = newText
        case days:
            voteDays = newText
        default:
            break
        }
        
        if voteNum != nil, votePrice != nil {
            if let voteNum2 = Int(voteNum!) {
                if let votePrice2 = Int(votePrice!) {
                    voteFee = voteNum2 * votePrice2
                    fee.text = String(voteFee!)
                }
            }
        }
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        voteAnswer = answer.text
//        voteNum = num.text!
//        votePrice = price.text!
//        voteLength = length.text
//        voteDays = days.text
//
//        if let voteNum2 = Int(voteNum!) {
//            print(voteNum2)
//            if let votePrice2 = Int(votePrice!) {
//                print(votePrice2)
//                voteFee = voteNum2 * votePrice2
//                fee.text = String(voteFee!)
//                print(fee)
//            }
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPutList" {
            let dest = segue.destination as! PutListTableController
            dest.voteAnswer = voteAnswer
            dest.voteNum = Int(voteNum!)
            dest.votePrice = Int(votePrice!)
            dest.voteFee = voteFee
            dest.voteLength = Int(voteLength!)
            dest.voteDays = Int(voteDays!)
        }
    }
    

    //MARK：Actions
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "投票未保存", message: "", preferredStyle: .alert)
        let option1 = UIAlertAction(title: "保存", style: .default, handler: nil)
        let option2 = UIAlertAction(title: "不，谢谢", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        ac.addAction(option1)
        ac.addAction(option2)
        self.present(ac, animated: true, completion: nil)
    }
    
    //传递数据到添加问题页面，并保证所有数据都已经填写完整。
    @IBAction func addQuestion(_ sender: UIButton) {
        voteAnswer = voteAnswer?.trimmingCharacters(in: .whitespaces)
        voteNum = voteNum?.trimmingCharacters(in: .whitespaces)
        votePrice = votePrice?.trimmingCharacters(in: .whitespaces)
        voteLength = voteLength?.trimmingCharacters(in: .whitespaces)
        voteDays = voteDays?.trimmingCharacters(in: .whitespaces)
        if voteAnswer != nil, voteNum != nil, votePrice != nil, voteFee != nil, voteLength != nil, voteDays != nil,voteAnswer != "", voteNum != "", votePrice != "", voteLength != "", voteDays != "" {
            self.performSegue(withIdentifier: "showPutList", sender: self)
        } else {
            let ac = UIAlertController(title: "信息填写不完整", message: "", preferredStyle: .alert)
            let option1 = UIAlertAction(title: "确定", style: .destructive, handler: nil)
            ac.addAction(option1)
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    
}
