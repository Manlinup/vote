//
//  AddBankCardTableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/10.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class AddBankCardTableViewController: UITableViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var nametext: UITextField!//持卡人
    @IBOutlet weak var cardmunbertext: UITextField!//卡号
    @IBOutlet weak var phonetext: UITextField! //电话号码
    var textcontant:String?//名字监听
    var textcontant2:String?//卡号监听
    var textcontant3:String?//电话监听
    
    override func viewDidLoad() {
        super.viewDidLoad()

            nametext.delegate = self
            cardmunbertext.delegate = self
            phonetext.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))//点击空白收起键盘

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //去除页脚
//        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //表格分割线颜色
       // tableView.separatorColor = UIColor(white: 0, alpha: 0)
    }
    @objc func handTap (sender:UITapGestureRecognizer){//点击空白收起键盘
        if sender.state == .ended{
            nametext.resignFirstResponder()
            cardmunbertext.resignFirstResponder()
            phonetext.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cardmunbertext.keyboardType = UIKeyboardType.numberPad //编辑时唤起数字键盘
        phonetext.keyboardType = UIKeyboardType.numberPad //编辑时唤起数字键盘
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //按回车收起键盘
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*
        nametext//持卡人
        cardmunbertext//卡号
        phonetext//电话号码
        */
        //姓名限制
        if textField == self.nametext{
            let futureString: NSMutableString = NSMutableString(string: nametext.text!)
            futureString.insert(string, at: range.location)
            if !futureString.isEqual(to: "") {//当输入框不为空
                if(futureString.length > 10){//设置最大数
                    return false
                }
            }
            textcontant = futureString as String
        }
        //银行卡限制
        if textField == self.cardmunbertext{
            let futureString2: NSMutableString = NSMutableString(string: cardmunbertext.text!)
            futureString2.insert(string, at: range.location)
            if !futureString2.isEqual(to: "") {//当输入框不为空
                    for ii in (0...(futureString2.length - 1)).reversed() {
                        let char = Character(UnicodeScalar(futureString2.character(at: ii))!)
                        if(char >= "0" && char <= "9") != true {//限制只能输入数字
                            return false
                        }
                        if(futureString2.length == 1 && char == "0"){//第一个数字不能为零
                            return false
                        }
                    }
                    if(futureString2.length > 18){//设置最大数额
                        return false
                    }
            }
            textcontant2 = futureString2 as String
            
            
        }
        
        //电话号码限制
       if textField == self.phonetext{
            let futureString3: NSMutableString = NSMutableString(string: phonetext.text!)
            futureString3.insert(string, at: range.location)
            if !futureString3.isEqual(to: "") {//当输入框不为空
                for iii in (0...(futureString3.length - 1)).reversed() {
                    let char2 = Character(UnicodeScalar(futureString3.character(at: iii))!)
                    if(char2 >= "0" && char2 <= "9") != true {//限制只能输入数字
                        return false
                    }
                    if(futureString3.length == 1 && char2 == "0"){//第一个数字不能为零
                        return false
                    }
                }
                if(futureString3.length > 11){//设置最大数额
                    return false
                }
            }
            textcontant3 = futureString3 as String
        }

        return true
    }

    
    
    
    @IBAction func save(_ sender: UIButton) {
      /*  @IBOutlet weak var nametext: UITextField!//持卡人
        @IBOutlet weak var cardmunbertext: UITextField!//卡号
        @IBOutlet weak var phonetext: UITextField! //电话号码
        var textcontant:String?//名字监听
        var textcontant2:String?//卡号监听
        var textcontant3:String?//电话监听
         */
        
        
          let name  = nametext.text!.trimmingCharacters(in: .whitespaces)//名字
          let card = cardmunbertext.text!.trimmingCharacters(in: .whitespaces)//卡号
          let phone = phonetext.text!.trimmingCharacters(in: .whitespaces) //电弧
      
            
                  let n1: NSMutableString = NSMutableString(string: name)
                  let n2: NSMutableString = NSMutableString(string: card)
                  let n3: NSMutableString = NSMutableString(string: phone)
                  let m1 = n1.length >= 2 ? true:false //名字大于等于2
                  let m2 = n1.length <= 10 ? true:false //名字小于等于10
                  let m3 = n2.length == 18 ? true:false //卡号等于18位
                  let m4 = n3.length == 11 ? true:false //手机号码11位
            
            
                if !name.isEqual("") && !card.isEqual("") && !phone.isEqual("") && m1 == true && m2 == true && m3 == true && m4 == true {
                    
                    //再此提交数据
                    alert("添加成功")
                   
                }else{
                    if name.isEqual(""){
                        alert("请填写姓名")
                        return
                    }
                    if m1 == false || m2 == false{
                        alert("请正确填写名字")
                        return
                    }
                    if card.isEqual(""){
                        alert("请填写卡号")
                        return
                    }
                    if m3 == false {
                        alert("请正确填写卡号")
                        return
                    }
                    if phone.isEqual(""){
                        alert("请填写预留号码")
                        return
                    }
                    if m4 == false {
                        alert("请正确填写预留号码")
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
