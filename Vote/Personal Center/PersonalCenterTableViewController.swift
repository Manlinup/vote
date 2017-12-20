//
//  PersonalCenterTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class PersonalCenterTableViewController: UITableViewController {

    
    @IBOutlet weak var gradientBg: UIView!
    @IBOutlet weak var gradientBtn0: UIButton!
    @IBOutlet weak var gradientBtn1: UIButton!
    @IBOutlet weak var gradientBtn2: UIButton!
    @IBOutlet weak var gradientBtn3: UIButton!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var stackview2: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Login()//跳转登录页面
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)//导航返回按钮样式
        tableView.backgroundColor = UIColor.white//(white: 0.98, alpha: 1)//表格背景颜色
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0, alpha: 0)//表格分割线颜色
        
        
        
        //颜色渐变
        let Tb = UIColor.init(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        let Ty = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        let Tb1 = UIColor.init(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
        let Ty1 = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        let  gradientLayer0 = CAGradientLayer()
        gradientLayer0.frame = self.tableView.bounds
        gradientLayer0.colors = [Tb.cgColor,Ty.cgColor]
        //gradientLayer.locations = [0.0,0.35]
        gradientLayer0.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer0.endPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientBg.layer.cornerRadius = 10
        self.gradientBg.clipsToBounds = true
        self.gradientBg.layer.addSublayer(gradientLayer0)
        
        let  gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.stackview.bounds
        gradientLayer.colors = [Tb1.cgColor,Ty1.cgColor]
        //gradientLayer.locations = [0.0,0.35]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientBtn0.layer.cornerRadius = 10
        self.gradientBtn0.clipsToBounds = true
        self.gradientBtn0.layer.addSublayer(gradientLayer)

        let  gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = self.stackview.bounds
        gradientLayer2.colors = [Tb1.cgColor,Ty1.cgColor]
        gradientLayer2.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer2.endPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientBtn1.layer.cornerRadius = 10
        self.gradientBtn1.clipsToBounds = true
        self.gradientBtn1.layer.addSublayer(gradientLayer2)
        
        let  gradientLayer3 = CAGradientLayer()
        gradientLayer3.frame = self.stackview2.bounds
        gradientLayer3.colors = [Tb1.cgColor,Ty1.cgColor]
        gradientLayer3.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer3.endPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientBtn2.layer.cornerRadius = 10
        self.gradientBtn2.clipsToBounds = true
        self.gradientBtn2.layer.addSublayer(gradientLayer3)
        
        let  gradientLayer4 = CAGradientLayer()
        gradientLayer4.frame = self.stackview2.bounds
        gradientLayer4.colors = [Tb1.cgColor,Ty1.cgColor]
        gradientLayer4.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer4.endPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientBtn3.layer.cornerRadius = 10
        self.gradientBtn3.clipsToBounds = true
        self.gradientBtn3.layer.addSublayer(gradientLayer4)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Login()//跳转登录页面
    }
    
    @IBAction func AccountLink(_ sender: UIButton) {//跳转账户
        
        performSegue(withIdentifier: "AccountLink", sender:self )
    }
    
    
    @IBAction func QuestionnaireLink(_ sender: UIButton) {//跳转问卷
         performSegue(withIdentifier: "QuestionnaireLink", sender:self )
    }
    
    
    @IBAction func UserInformationEditingLink(_ sender: UIButton) {//跳转用户信息编辑
         performSegue(withIdentifier: "UserInformationEditingLink", sender:self )
    }
    
    @IBAction func MyDraftLink(_ sender: UIButton) {//跳转我的草稿
        performSegue(withIdentifier: "MyDraftLink", sender: self)
    }
    
    
    @IBAction func myvote(_ sender: UIButton) {//我的投票
        alert("努力建设中...")
    }
    
    
    
    @IBAction func setLink(_ sender: UIBarButtonItem) {//跳转到设置
        performSegue(withIdentifier: "setLink", sender: self)
    }
    
    
    func Login(){//登录页面
                let LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginviewController") as! LoginTableViewController
                    self.present(LoginViewController, animated: true, completion: nil)
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
