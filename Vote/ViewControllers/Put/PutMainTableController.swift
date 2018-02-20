//
//  PutMainTableController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/15.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

protocol PutMainTableControllerDelegate {
    func updateSurveyTarget(text: String)
}

class PutMainTableController: UITableViewController, UITextFieldDelegate, PutMainTableControllerDelegate {

    @IBOutlet weak var answer: UITextField!//谁来回答
    @IBOutlet weak var num: UITextField!//问卷数量
    @IBOutlet weak var price: UITextField!//选题数目
    @IBOutlet weak var fee: UITextField!//发布总价
    @IBOutlet weak var unitprice: UITextField!//选题单价
    @IBOutlet weak var length: UITextField!//问卷单价
    @IBOutlet weak var days: UITextField!//调查周期
    
    var voteNum: String?//问卷数量监听
    var votePrice: String?//选题数目监听
    var voteunitprice: String?//选题单价监听
    var voteLength: String?//问卷单价监听
    var voteName: String?//接收标题
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answer.delegate = self
        num.delegate = self
        price.delegate = self
        length.delegate = self
        days.delegate = self
        unitprice.delegate = self
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))
        tableView.separatorColor = UIColor(white: 1, alpha: 0)
        
        self.title = voteName
        
        var placeholdercolor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        answer.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        num.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        price.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        length.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        days.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        unitprice.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)//导航返回按钮样式
    }
    
    @objc func handTap (sender:UITapGestureRecognizer){
        if sender.state == .ended{
            answer.resignFirstResponder()
            num.resignFirstResponder()
            price.resignFirstResponder()
            length.resignFirstResponder()
            days.resignFirstResponder()
            unitprice.resignFirstResponder()
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
        
        switch textField {//谁来回答/禁止问卷单价/发布总价编辑
        case self.answer:
            return false
        case self.length:
            return false
        case self.fee:
            return false
        default:break
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //关闭键盘
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
//        let currentText = textField.text ?? ""
//        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        Calculatetheprice(textField,range,string)//计算价格
        switch textField {
        case num://问卷数量
            return textFieldVariety(9,textField,range,string)//限制长度，非数字输入
        case price://选题数目
            return textFieldVariety(3,textField,range,string)//限制长度，非数字输入
        case unitprice://选题单价
            return textFieldVariety(4,textField,range,string)//限制长度，非数字输入
        case days://选题周期
             return textFieldVariety(3,textField,range,string)//限制长度，非数字输入
        default:
            break
        }
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
        return bool
    }
    
    func Calculatetheprice(_ textField: UITextField,_ range: NSRange,_ string: String){//计算价格
        let futureString: NSMutableString = NSMutableString(string: textField.text!)
        futureString.insert(string, at: range.location)
        switch  textField {
        case self.num://问卷数量
            voteNum = futureString.trimmingCharacters(in: .whitespaces)//获取问卷数量
        case self.price://选题数量
            votePrice = futureString.trimmingCharacters(in: .whitespaces)//获取选题数量
        case self.unitprice://选题单价
            voteunitprice = futureString.trimmingCharacters(in: .whitespaces)///获取选题单价
        case self.length://问卷单价
            voteLength = futureString.trimmingCharacters(in: .whitespaces)///获取问卷单价
        default:break
        }
        if votePrice != nil && voteunitprice != nil  {//如果选题数量和单价不为nil
            let n1:Double = (votePrice! as NSString).doubleValue//选题数量类型转换
            let n2:Double = (voteunitprice! as NSString).doubleValue//选题单价类型转换
            let n3:Double = n1 * n2 //计算问卷单价
            self.length.text = "\(n3)"//赋予单价
            voteLength = "\(n3)"
            if(voteNum != nil && voteLength != nil ){//如果问卷数量和问卷单价不为nil
                let n4:Double = (voteNum! as NSString).doubleValue//问卷数量类型转换
                self.fee.text = "\(n3*n4)"//计算发布总价
            }
         }
    }
    
    @IBAction func surveytarget(_ sender: UIButton) {//跳转谁来回答
//         performSegue(withIdentifier: "SurveyTargetLink", sender:self)
        
        if let contentVc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyTarget01") as? SurveyTarget01TableViewController {
            contentVc.delegate = self
            let navigationVC = UINavigationController(rootViewController: contentVc)
            
            self.navigationController?.present(navigationVC, animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 
    //MARK：Actions
    /*
     answer: UITextField!//谁来回答
     num: UITextField!//问卷数量
     price: UITextField!//选题数目
     fee: UITextField!//发布总价
     unitprice: UITextField!//选题单价
     length: UITextField!//问卷单价
     days: UITextField!//调查周期
     */
    //以下变量用于转场传值
    var c1:String?//谁来回答
    var c2:Int32?//问卷数量
    var c3:Int32?//选题数目
    var c4:Double?//选题单价
    var c5:Int32?//调查周期
    var c6:Double?//问卷单价
    var c7:Double?//发布总价
    //传递数据到添加问题页面，并保证所有数据都已经填写完整。
    @IBAction func addQuestion(_ sender: UIButton) {
        let m1 = answer.text!.trimmingCharacters(in: .whitespaces)//谁来回答
        let m2 = num.text!.trimmingCharacters(in: .whitespaces)//问卷数量
        let m3 = price.text!.trimmingCharacters(in: .whitespaces)//选题数目
        let m4 = unitprice.text!.trimmingCharacters(in: .whitespaces)//选题单价
        let m5 = days.text!.trimmingCharacters(in: .whitespaces)//调查周期
        let m6 = length.text!.trimmingCharacters(in: .whitespaces)//问卷单价
        let m7 = fee.text!.trimmingCharacters(in: .whitespaces)//发布总价
        if !m1.isEqual("") && !m2.isEqual("") && !m3.isEqual("") && !m4.isEqual("") && !m5.isEqual("") && !m6.isEqual("") && !m7.isEqual(""){
                c1 = m1
                c2 = (m2 as NSString).intValue
                c3 = (m3 as NSString).intValue
                c4 = (m4 as NSString).doubleValue
                c5 = (m5 as NSString).intValue
                c6 = (m6 as NSString).doubleValue
                c7 = (m7 as NSString).doubleValue
                let d1:Int32 = c2!
                let d2:Int32 = c3!
                let d3:Double = c4!
                let d4:Int32 = c5!
                let d5:Double = c6!
                let d6:Double = c7!
            if(d1 >= 0 && d2 >= 0 && d3 >= 0.0 && d4 >= 0 && d5 >= 0.0 && d6 >= 0.0){//判断所有的值是否都是正数
                 self.performSegue(withIdentifier: "showPutList", sender: self)
            } else {
                alert("未知错误")
            }
        } else {
           alert("填写信息不完整")
        }
    }
    func alert( _ title:String){
        let ac = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let option1 = UIAlertAction(title: "确定", style: .destructive, handler: nil)
        ac.addAction(option1)
        self.present(ac, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPutList" {
            let dest = segue.destination as! PutListTableController
                dest.voteAnswer = c1! //谁来回答
                dest.voteNum = c2!//问卷数量
                dest.QuestionnaireLength = c3! //选题数量
                dest.unitprice = c4! //选题单价
                dest.voteDays = c5!//周期
                dest.voteunitprice = c6! //问卷单价
                dest.voteFee = c7! //发布总价
                dest.voteName = String(voteName!)//问卷标题
        }
       
    }
    
    // MARK - Action
    func updateSurveyTarget(text: String) {
            answer.text = text
    }
    
    //SurveyTargetLink
    @IBAction func closeSurveyTarget(segue:UIStoryboardSegue){
        if segue.identifier == "closeSurveyTargetlast" {
            let info = segue.source as! SurveyTarget01TableViewController
            if let dest = info.saveText {
                answer.text = dest
            }
            
        }
    }
}
