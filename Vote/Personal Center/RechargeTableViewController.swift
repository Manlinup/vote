//
//  RechargeTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class RechargeTableViewController: UITableViewController,UITextFieldDelegate {

    
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var alipayimg: UIImageView!
    @IBOutlet weak var wechatimg: UIImageView!
    
    var amountnumber = "100"
    override func viewDidLoad() {
        super.viewDidLoad()
        input.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTap)))
        
        tableView.separatorColor = UIColor(white:0, alpha: 0)//表格分割线颜色
        
        //导航返回按钮样式
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //按钮样式
        self.btn0.layer.borderWidth = 1.0
        self.btn0.layer.borderColor = UIColor(red: 83/255, green: 178/255, blue: 115/255, alpha: 1.0).cgColor
        self.btn1.layer.borderWidth = 1.0
        self.btn1.layer.borderColor = UIColor(red: 83/255, green: 178/255, blue: 115/255, alpha: 1.0).cgColor
        self.btn2.layer.borderWidth = 1.0
        self.btn2.layer.borderColor = UIColor(red: 83/255, green: 178/255, blue: 115/255, alpha: 1.0).cgColor
        self.btn3.layer.borderWidth = 1.0
        self.btn3.layer.borderColor = UIColor(red: 83/255, green: 178/255, blue: 115/255, alpha: 1.0).cgColor
        self.btn4.layer.borderWidth = 1.0
        self.btn4.layer.borderColor = UIColor(red: 83/255, green: 178/255, blue: 115/255, alpha: 1.0).cgColor
    
    }
    
  @objc func handTap (sender:UITapGestureRecognizer){//点击空白收起键盘
        if sender.state == .ended{
            input.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.keyboardType = UIKeyboardType.numberPad //编辑时唤起数字键盘
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //按回车收起键盘
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let futureString: NSMutableString = NSMutableString(string: textField.text!)
        futureString.insert(string, at: range.location)
        if !futureString.isEqual(to: "") {//当输入框不为空
            for i in (0...(futureString.length - 1)).reversed() {
                let char = Character(UnicodeScalar(futureString.character(at: i))!)
                if(char >= "0" && char <= "9") != true {//限制只能输入数字
                    return false
                }
                if(futureString.length == 1 && char == "0"){//第一个数字不能为零
                    return false
                }
            }
            if(futureString.length > 5){//设置最大数额
                return false
            }
        }
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == input { //输入框变动获取其值
            amountnumber = newText
        }
        return true
    }
    
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            alipayimg.image = #imageLiteral(resourceName: "truechecked")
            wechatimg.image = #imageLiteral(resourceName: "falsechecked")
         
        } else if(indexPath.row == 1) {
            
            alipayimg.image = #imageLiteral(resourceName: "falsechecked")
            wechatimg.image = #imageLiteral(resourceName: "truechecked")
            
        }
    }
    
    
    @IBAction func clickbtn(_ sender: UIButton) {
//        var btntext = sender.currentTitle!
        var btntext = ""
        if (sender.tag == 100){
            btntext = "100"
            sender.backgroundColor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)
            btn1.backgroundColor = UIColor.clear
            btn2.backgroundColor = UIColor.clear
            btn3.backgroundColor = UIColor.clear
          //  btn4.backgroundColor = UIColor.clear
            sender.setTitleColor(UIColor.white, for: .normal)
            btn1.setTitleColor(UIColor.black, for: .normal)
            btn2.setTitleColor(UIColor.black, for: .normal)
            btn3.setTitleColor(UIColor.black, for: .normal)
          //  btn4.setTitleColor(UIColor.black, for: .normal)
        } else if( sender.tag == 50 ){
             btntext = "50"
            btn0.backgroundColor = UIColor.clear
            sender.backgroundColor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)
            btn2.backgroundColor = UIColor.clear
            btn3.backgroundColor = UIColor.clear
           // btn4.backgroundColor = UIColor.clear
            btn0.setTitleColor(UIColor.black, for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
            btn2.setTitleColor(UIColor.black, for: .normal)
            btn3.setTitleColor(UIColor.black, for: .normal)
          //  btn4.setTitleColor(UIColor.black, for: .normal)
        }else if( sender.tag == 30 ){
            btntext = "30"
            btn0.backgroundColor = UIColor.clear
            btn1.backgroundColor = UIColor.clear
            sender.backgroundColor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)
            btn3.backgroundColor = UIColor.clear
           // btn4.backgroundColor = UIColor.clear
            btn0.setTitleColor(UIColor.black, for: .normal)
            btn1.setTitleColor(UIColor.black, for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
            btn3.setTitleColor(UIColor.black, for: .normal)
           // btn4.setTitleColor(UIColor.black, for: .normal)
        }else if( sender.tag == 10 ){
             btntext = "10"
            btn0.backgroundColor = UIColor.clear
            btn1.backgroundColor = UIColor.clear
            btn2.backgroundColor = UIColor.clear
            sender.backgroundColor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)
           // btn4.backgroundColor = UIColor.clear
            btn0.setTitleColor(UIColor.black, for: .normal)
            btn1.setTitleColor(UIColor.black, for: .normal)
            btn2.setTitleColor(UIColor.black, for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
            //btn4.setTitleColor(UIColor.black, for: .normal)
        }
        input.text = ""
        amountnumber = btntext.trimmingCharacters(in: .whitespaces)
    }
    
    
    @IBAction func save(_ sender: UIButton) {//保存数据
        if !amountnumber.isEqual(""){
            let savemunber = (amountnumber as NSString).intValue//最大提现金额
            if(savemunber > 0){
                
                alert("充值\(amountnumber)元成功")
                
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
