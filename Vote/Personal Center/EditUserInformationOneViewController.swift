//
//  EditUserInformationOneViewController.swift
//  Vote
//
//  Created by mc on 2017/11/29.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class EditUserInformationOneViewController: UIViewController,UITextFieldDelegate {
   
    @IBOutlet weak var input: UITextField!
    var munbertype:Int = 0
    var initializationtext:String = ""
    var contanttext = "" //用于监听内容变化
    var savetext:String? //存储
    let udname = UserDefaultsKey.personalinformation()//获取UserDefaults名称
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defalts = UserDefaults.standard
        //munbertype监听是那个栏目进来的  2.昵称  5.签名 7.公司
        munbertype = defalts.integer(forKey:udname.munbertype)
        //获取已有内容赋予输入框
        initializationtext = defalts.string(forKey:udname.inputtext)!
        input.text = initializationtext
        contanttext = initializationtext
        if(munbertype == 2){
            self.title = "编辑昵称"
        }else if (munbertype == 5){
            self.title = "编辑签名"
        }else if(munbertype == 7){
            self.title = "编辑公司"
        }
        
        input.delegate = self
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))//点击空白收起键盘.
    }
    
    @objc func handTap (sender:UITapGestureRecognizer){//点击空白收起键盘
        if sender.state == .ended{
            input.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()//按回车键收起键盘
        return true
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let futureString: NSMutableString = NSMutableString(string: textField.text!)
        futureString.insert(string, at: range.location)
        if !futureString.isEqual(to: "") && munbertype == 2 {//限制昵称长度
            if(futureString.length > 11){//设置最大数额
                return false
            }
        }
        //输入框变动获取其值
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if textField == input {
            contanttext = newText
        }
        return true
    }

    @IBAction func save(_ sender: UIBarButtonItem) {//存储数据
        let inputcontant = input.text!
        if(inputcontant.isEqual("") == false && inputcontant != initializationtext && contanttext.isEqual("") == false ){
            if(munbertype == 2){//昵称
                savetext = contanttext
            }else if (munbertype == 5){//签名
                savetext = contanttext
            }else if(munbertype == 7){//公司
               savetext = contanttext
            }
            performSegue(withIdentifier: "closeEditUserOne", sender:self)//转场
            
        }else if(inputcontant.isEqual("") == true){
            alert("没有内容可提交")
        }else if (inputcontant == initializationtext){
            alert("内容无改变")
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
