//
//  LoginTableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/11.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var phonetext: UITextField!//手机号
    @IBOutlet weak var codetext: UITextField!//验证码
    
    var textcontant:String?//数据监听
    var textcontant2:String?//数据监听
    @IBOutlet weak var codewarp: UIView!
    var codebtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phonetext.delegate = self
        codetext.delegate = self
       
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         //去除页脚
         tableView.tableFooterView = UIView(frame: CGRect.zero)
        //表格分割线颜色
         tableView.separatorColor = UIColor(white: 0, alpha: 0)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))
        
        
        
        let color = UIColor.init(red: 58/255, green: 133/255, blue: 62/255, alpha: 1)
        codebtn = UIButton()
        codebtn.frame.size.width = codewarp.frame.size.width
        codebtn.frame.size.height = codewarp.frame.size.height
        codebtn.setTitleColor(color, for: .normal)
        codebtn.setTitle("获取验证码", for: .normal)
        codebtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.codewarp.addSubview(codebtn)
        codebtn.addTarget(self, action: #selector(sendButtonClick), for: .touchUpInside)//触发按钮
        
        
        
        var placeholdercolor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
       phonetext.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
       codetext.setValue(placeholdercolor, forKeyPath: "placeholderLabel.textColor")//设置placeholder颜色
      
    }
    
    @objc func handTap (sender:UITapGestureRecognizer){//点击空白处收起键盘
        if sender.state == .ended{
            phonetext.resignFirstResponder()
            codetext.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.keyboardType = UIKeyboardType.decimalPad//编辑时唤醒数字键盘
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()//按回车键收起键盘
        return true
    }
    var flagtwo = true //监听只能输入一个小数点
    var ftext = ""//监听只能输入一个小数点
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.phonetext {//手机号码
            textField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
            let futureString: NSMutableString = NSMutableString(string: phonetext.text!)
                    futureString.insert(string, at: range.location)
                    if !futureString.isEqual(to: "") {//当输入框不为空
                        for i in (0...(futureString.length - 1)).reversed() {//反向循环
                            let char = Character(UnicodeScalar(futureString.character(at: i))!)
                            if(char >= "0" && char <= "9") != true {//限制只能输入数字
                                return false
                            }
                            if(futureString.length == 1 && char == "0"){//第一个数字不能为零
                                return false
                            }
                        }
                        if(futureString.length > 11){//设置输入框长度
                            return false
                        }
                    }
            
                    textcontant = futureString as String
        }
        if textField == self.codetext {//验证码
            textField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
            let futureString2: NSMutableString = NSMutableString(string: codetext.text!)
            futureString2.insert(string, at: range.location)
            if !futureString2.isEqual(to: "") {//当输入框不为空
                for ii in (0...(futureString2.length - 1)).reversed() {//反向循环
                    let char = Character(UnicodeScalar(futureString2.character(at: ii))!)
                    if(char >= "0" && char <= "9") != true {//限制只能输入数字
                        return false
                    }
                }
                if(futureString2.length > 6){//设置输入框长度
                    return false
                }
            }
            textcontant2 = futureString2 as String
        }
        return true
    }
    
    
    
    /*========================发送验证码========================================*/
    var resend = true
    @objc func sendButtonClick(sender: UIButton) {//触发函数
        phonetext.resignFirstResponder()//收起键盘
        codetext.resignFirstResponder()//收起键盘
        let phone  = phonetext.text!.trimmingCharacters(in: .whitespaces)//手机号/并去空
        let n1: NSMutableString = NSMutableString(string: phone)
        let m1 = n1.length == 11 ? true:false //手机号设置长度
        if !phone.isEqual("") && m1 == true{
            if( resend == true){
                
                // 启动倒计时
                isCounting = true
                resend = false
                alert("已发送")
            }
        } else {
            
            if phone.isEqual("") {
                alert("请输入手机号码")
                return
            }
            if m1 == false {
                alert("请输入正确手机号码")
                return
            }
            
        }
    }

    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {//当remainingSeconds发生改变触发//newValue为改变的值
            codebtn.setTitle("重新发送(\(newValue))", for: .normal)
            if newValue <= 0 {
                codebtn.setTitle("重新发送", for: .normal)
                isCounting = false
                resend = true
            }
        }
    }
    var isCounting = false {//当isCounting发生改变触发//newValue为改变的值
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                    remainingSeconds = 60
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }

            codebtn.isEnabled = !newValue //改变按钮状态false为禁用，true反之
        }
    }
    @objc func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    /*=====================================================================*/
    
    

    @IBAction func colse(_ sender: UIButton) {//登录按钮
        /*
        @IBOutlet weak var phonetext: UITextField!//手机号
        @IBOutlet weak var codetext: UITextField!//验证码
        var textcontant:String?//数据监听
        var textcontant2:String?//数据监听*/
        
        let phone  = phonetext.text!.trimmingCharacters(in: .whitespaces)//手机号/并去空
        let code = codetext.text!.trimmingCharacters(in: .whitespaces)//验证码/并去空
        
        
        let n1: NSMutableString = NSMutableString(string: phone)
        let n2: NSMutableString = NSMutableString(string: code)
        let m1 = n1.length == 11 ? true:false //手机号设置长度
        let m2 = n2.length == 6 ? true:false //验证码长度

        
        
        if !phone.isEqual("") && !code.isEqual("") && m1 == true && m2 == true {
            
            //再此提交数据
            alert("添加成功")
            
        }else{
            if phone.isEqual(""){
                alert("请填手机号码")
                return
            }
            if m1 == false{
                alert("请正确填写手机号码")
                return
            }
            if code.isEqual(""){
                alert("请填写验证码")
                return
            }
            if m2 == false {
                alert("请正确填写验证码")
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
