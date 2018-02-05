//
//  WithdrawTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class WithdrawTableViewController: UITableViewController,UITextFieldDelegate {


    
    
    @IBOutlet weak var maxwithdrawal: UILabel!
    @IBOutlet weak var inputBoxView: UIView!
    @IBOutlet weak var input: UITextField!
    var amonunt = ""
    
    @IBOutlet weak var alipayimg: UIImageView!
    @IBOutlet weak var wechatimg: UIImageView!
    @IBOutlet weak var bankardimg: UIImageView!
    var verification = false
    override func viewDidLoad() {
        super.viewDidLoad()
        input.delegate = self
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))
       
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // 表格分割线颜色
        tableView.separatorColor = UIColor(white:0, alpha: 0)
        
        //导航返回按钮样式
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //设置输入框阴影
        self.inputBoxView.layer.shadowOpacity = 0.2
        self.inputBoxView.layer.shadowColor = UIColor.black.cgColor
        self.inputBoxView.layer.shadowOffset = CGSize(width: 0, height:0)
        self.inputBoxView.layer.cornerRadius = 5
        self.inputBoxView.layer.shadowRadius = 3
    }
    
    @objc func handTap (sender:UITapGestureRecognizer){//点击空白处收起键盘
        if sender.state == .ended{
            input.resignFirstResponder()
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
        
        textField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        let futureString: NSMutableString = NSMutableString(string: textField.text!)
        futureString.insert(string, at: range.location)
        var flag = 0
        let limited = 2//小数点后需要限制的个数
        if !futureString.isEqual(to: "") {//当输入框不为空
           
            if (flagtwo == false && Character(UnicodeScalar(futureString.character(at:futureString.length - 1 ))!) == "."){//只能输入一个小数点
                ftext = "."
            }else{
                ftext = ""
            }
            for i in (0...(futureString.length - 1)).reversed() {//反向循环
                let char = Character(UnicodeScalar(futureString.character(at: i))!)
                if char == "." {////设置不能超过2位小数
                    if flag > limited {
                        return false
                    }
                    if(flagtwo == true){//只能输入一个小数点
                        flagtwo = false
                    }
                    break
                }
                flag += 1
                
                if(char >= "0" && char <= "9" || futureString == ".") != true {//限制只能输入数字跟“.”
                    return false
                }
            }
            if(futureString.length == 1 && futureString == "."||futureString == "0"){//限制第一个不能为“.”
                return false
            }
           
            if(flagtwo == false && ftext == "."){//只能输入一个小数点
                return false
            }
        }
        
        //输入框变动获取其值
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == input {
            amonunt = newText.trimmingCharacters(in: .whitespaces)//去空
        }
  
        return true
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//点击更换图标
        if (indexPath.row == 0) {
            alipayimg.image = #imageLiteral(resourceName: "truechecked")
            wechatimg.image = #imageLiteral(resourceName: "falsechecked")
            bankardimg.image = #imageLiteral(resourceName: "falsechecked")

        } else if(indexPath.row == 1) {

            alipayimg.image = #imageLiteral(resourceName: "falsechecked")
            wechatimg.image = #imageLiteral(resourceName: "truechecked")
            bankardimg.image = #imageLiteral(resourceName: "falsechecked")

        } else if (indexPath.row == 2){
            alipayimg.image = #imageLiteral(resourceName: "falsechecked")
            wechatimg.image = #imageLiteral(resourceName: "falsechecked")
            bankardimg.image = #imageLiteral(resourceName: "truechecked")
        }
    }
    
    
    
    
    @IBAction func save(_ sender: UIButton) {//保存数据
        let text = input.text!.trimmingCharacters(in: .whitespaces)
        let  index:NSMutableString = NSMutableString(string:text)
    
        if !text.isEqual("") {
            
            let maxmunber = self.maxwithdrawal.text!
            let maxnumbertwo:Double = (maxmunber as NSString).doubleValue//最大提现金额
            let maxfutureString:Double = (text as NSString).doubleValue//最大输入提现金额
            
            let lastmnber = Character(UnicodeScalar(index.character(at:index.length - 1 ))!)//获取输入框最后一位数
            
            if(amonunt.isEqual("") == true || lastmnber == "." ){
                 alert("请输入正确金额")//当最后一位数为“.”时
            }else if(maxfutureString>maxnumbertwo){
                 alert("超出可提现金额")//提现金额超出可提现金额
            }else{
                let savemuber:Double = (amonunt as NSString).doubleValue//最大提现金额
                if(savemuber > 0){
                    
                    alert("提现\(savemuber)元成功")
                    
                }
            }
            
        }else{
            alert("请输入金额")
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
