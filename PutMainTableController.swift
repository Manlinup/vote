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
    var voteName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer.delegate = self
        num.delegate = self
        price.delegate = self
        length.delegate = self
        days.delegate = self
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))
        tableView.separatorColor = UIColor(white: 1, alpha: 0)
        
        self.title = voteName
        
        var placeholdercolor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        answer.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        num.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        price.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        length.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        days.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)//导航返回按钮样式
    }
     
    
    @objc func handTap (sender:UITapGestureRecognizer){
        if sender.state == .ended{
            answer.resignFirstResponder()
            num.resignFirstResponder()
            price.resignFirstResponder()
            length.resignFirstResponder()
            days.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
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
            voteNum = newText//样本数量
            return textFieldVariety(9,textField,range,string)//限制长度，非数字输入
        case price:
            votePrice = newText//样本单价
            return textFieldVariety(4,textField,range,string)//限制长度，非数字输入
        case length:
            voteLength = newText//样本长度
            return textFieldVariety(4,textField,range,string)//限制长度，非数字输入
        case days:
            voteDays = newText//样本周期
             return textFieldVariety(4,textField,range,string)//限制长度，非数字输入
        default:
            break
        }
//        if voteNum != nil, votePrice != nil {
//            if let voteNum2 = Int(voteNum!) {
//                if let votePrice2 = Int(votePrice!) {
//                    voteFee = voteNum2 * votePrice2
//                    fee.text = String(voteFee!)
//                }
//            }
//        }
        return true
    }
    
    //设置输入框输入长度，限制输入非阿拉伯数字
    func textFieldVariety(_ maxlenght:Int ,_ textField: UITextField,_ range: NSRange,_ string: String) -> Bool{
        let futureString: NSMutableString = NSMutableString(string: textField.text!)
        futureString.insert(string, at: range.location)
        var bool:Bool = true
        if (futureString.length > maxlenght ){
            bool = false
        }
        for i in (0...(futureString.length - 1)).reversed() {//反向循环
            let char = Character(UnicodeScalar(futureString.character(at: i))!)
            if(char >= "0" && char <= "9") != true {//限制只能输入数字
                bool = false
            }
            if(futureString.length == 1 && char == "0"){//第一个数字不能为零
               bool = false
            }
        }
        
        if voteNum != nil, votePrice != nil {
            if let voteNum2 = Int(voteNum!) {
                if let votePrice2 = Int(votePrice!) {
                    voteFee = voteNum2 * votePrice2
                    fee.text = String(voteFee!)
                }
            }
        }
        
        return bool
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
            dest.voteName = String(voteName!)
            
        }
    }
    

    //MARK：Actions
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "投票未保存", message: "", preferredStyle: .alert)
        let option1 = UIAlertAction(title: "保存", style: .default, handler: nil)
        let option2 = UIAlertAction(title: "不，谢谢", style: .cancel) { (_) in
                self.performSegue(withIdentifier: "backToFirst", sender: self)
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
