//
//  MultipleChoiceTableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class MultipleChoiceTableViewController: UITableViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var SelectedTopicsTitle: UITextField!//选题标题
    @IBOutlet weak var SelectedTopicsA: UITextField!//选项一
    @IBOutlet weak var SelectedTopicsB: UITextField!//选项二
    @IBOutlet weak var SelectedTopicsC: UITextField!//选项三
    @IBOutlet weak var SelectedTopicsD: UITextField!//选项四
    
    
    
    let udname = UserDefaultsKey.SelectedTopicsType()//获取UserDefaults名称
    var optiontype = 0 //监听题目类型
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectedTopicsTitle.delegate = self
        SelectedTopicsA.delegate = self
        SelectedTopicsB.delegate = self
        SelectedTopicsC.delegate = self
        SelectedTopicsD.delegate = self
      
        
        let defalts = UserDefaults.standard
       //optiontype监听是那个选项进来的  1001.单选  1002.多选
        optiontype = defalts.integer(forKey:udname.optiontype)
        print(optiontype)
        if (optiontype == 1001) {
            self.title = "单选"
        } else if (optiontype == 1002){
            self.title = "多选"
        }
        
        // 表格分割线颜色
        tableView.separatorColor = UIColor(white:0, alpha: 0)
        
        var placeholdercolor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
         SelectedTopicsTitle.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        SelectedTopicsA.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        SelectedTopicsB.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        SelectedTopicsC.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        SelectedTopicsD.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))//添加点击空白收缩键盘事件
        
        
    }
    
    @objc  func handTap(sender:UITapGestureRecognizer) {//点击空白收缩键盘
        if sender.state == .ended{
            SelectedTopicsTitle.resignFirstResponder()
            SelectedTopicsA.resignFirstResponder()
            SelectedTopicsB.resignFirstResponder()
            SelectedTopicsC.resignFirstResponder()
            SelectedTopicsD.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//点击return收缩键盘
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {//
        let futureString: NSMutableString = NSMutableString(string: textField.text!)
        futureString.insert(string, at: range.location)
        switch textField {
        case self.SelectedTopicsTitle:
          return textFieldVariety(45,futureString)//限制选题标题45字符
        case self.SelectedTopicsA:
          return textFieldVariety(14,futureString)//限制选题选项14字符
        case self.SelectedTopicsB:
          return textFieldVariety(14,futureString)//限制选题选项14字符
        case self.SelectedTopicsC:
           return textFieldVariety(14,futureString)//限制选题选项14字符
        case self.SelectedTopicsD:
           return textFieldVariety(14,futureString)//限制选题选项14字符
        default:break
        }
        return true
    }
    
    //限制输入框输入长度函数
    func textFieldVariety(_ maxlenght:Int  ,_ futureString: NSMutableString) -> Bool{
        var bool:Bool = true
        if (futureString.length > maxlenght ){
             bool = false
        }
        return bool
    }
    
    
    @IBOutlet weak var btn01: UIButton!
    @IBOutlet weak var btn02: UIButton!
    @IBOutlet weak var btn03: UIButton!
    @IBOutlet weak var btn04: UIButton!
    
    @IBAction func selectdbtn(_ sender: UIButton) {//默认选项
        
        if (optiontype == 1001) {//单选
            
            if sender.tag == 10001{
                btn01.isSelected = true
                btn02.isSelected = false
                btn03.isSelected = false
                btn04.isSelected = false
            } else if sender.tag == 10002 {
                btn01.isSelected = false
                btn02.isSelected = true
                btn03.isSelected = false
                btn04.isSelected = false
            } else if sender.tag == 10003 {
                btn01.isSelected = false
                btn02.isSelected = false
                btn03.isSelected = true
                btn04.isSelected = false
            } else if sender.tag == 10004 {
                btn01.isSelected = false
                btn02.isSelected = false
                btn03.isSelected = false
                btn04.isSelected = true
            }
            
        } else if (optiontype == 1002){//多选
            
            sender.isSelected = sender.isSelected ? false:true
        }
        
        
    }
    
 
    @IBAction func submitsave(_ sender: UIButton) {
        /*
         SelectedTopicsTitle: UITextField!//选题标题
         SelectedTopicsA: UITextField!//选项一
         SelectedTopicsB: UITextField!//选项二
         SelectedTopicsC: UITextField!//选项三
         SelectedTopicsD: UITextField!//选项四
         */
        let titletext = SelectedTopicsTitle.text!.trimmingCharacters(in: .whitespaces)
        let  selectedtextA =  SelectedTopicsA.text!.trimmingCharacters(in: .whitespaces)
        let  selectedtextB =  SelectedTopicsB.text!.trimmingCharacters(in: .whitespaces)
        let  SelectedtextC =  SelectedTopicsC.text!.trimmingCharacters(in: .whitespaces)
        let  SelectedtextD =  SelectedTopicsD.text!.trimmingCharacters(in: .whitespaces)
        
        if !titletext.isEqual("") && !selectedtextA.isEqual("") && !selectedtextB.isEqual("") && !SelectedtextC.isEqual("") && !SelectedtextD.isEqual(""){
            
            //再此提交数据
            alert("添加成功")
            performSegue(withIdentifier: "closeMultipleChoice", sender: self)
            
        }else{
            
            if titletext.isEqual(""){
                alert("请填写题目标题")
            }
            if selectedtextA.isEqual("") || selectedtextB.isEqual("") || SelectedtextC.isEqual("") || SelectedtextD.isEqual(""){
                 alert("选项内容不完整")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    
    
    
    
    
    
    
    
    

    // MARK: - Table view data source
  /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
