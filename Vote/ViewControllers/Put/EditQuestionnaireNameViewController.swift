//
//  EditQuestionnaireNameViewController.swift
//  Vote
//
//  Created by mc on 2017/12/13.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class EditQuestionnaireNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var surveyName: UITextField!//输入框
    
    @IBOutlet weak var maxnumber: UILabel!//最大长度
    var surName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑问卷名称"
        surveyName.delegate = self
        var placeholdercolor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        surveyName.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))//添加点击空白收缩键盘事件
        
   
    }
    
    @objc  func handTap(sender:UITapGestureRecognizer) {//点击空白收缩键盘
        if sender.state == .ended{
            surveyName.resignFirstResponder()
        }
    }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {//点击return收缩键盘
          textField.resignFirstResponder()
          return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {//
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == surveyName {
            surName = newText
        }
        if (newText.characters.count > 35){
            return false
        }
        maxnumber.text = "\(newText.characters.count)"
        return true
    }

    

    @IBAction func EditOK(_ sender: UIButton) {
          surveyName.resignFirstResponder()//收起键盘
        let surveyname = surveyName.text!.trimmingCharacters(in: .whitespaces) //输入框内容/并清除空格
        let surName2 = surName.trimmingCharacters(in: .whitespaces) //清除空格
        let n1: NSMutableString = NSMutableString(string: surveyname)
        let m1 = n1.length >= 2 ? true:false //设置输入框值最小长度
        
        if !surName2.isEqual("") && !surveyname.isEqual("") && m1 == true{
            
            let munto = UIAlertController(title:"将更改为", message: "\(surveyname)", preferredStyle:.alert)
            let op = UIAlertAction(title: "确定", style: .cancel, handler: { (_) in
                
                 self.performSegue(withIdentifier: "CloseEditQuestionnaireName", sender: self)//转场至发布投票
                
            })
            let op2 = UIAlertAction(title: "取消", style: .destructive, handler: nil)
            munto.addAction(op)
            munto.addAction(op2)
            self.present(munto, animated: true, completion: nil)
            
        } else {
            if surName2.isEqual("") || surveyname.isEqual(""){
                alert("名称不能为空")
                return
            }
            if m1 == false {
                alert("名称不规范")
                return
            }
            
        }
    }
    func alert(_ alerttext:String){
        //弹框
        let munt = UIAlertController(title:alerttext, message: nil, preferredStyle: .alert)
        self.present(munt, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){//设置弹框显示时间
            self.presentedViewController?.dismiss(animated: false, completion: nil)
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
