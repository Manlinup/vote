//
//  AccountTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {

    @IBOutlet weak var viewBox0: UIView!
    @IBOutlet weak var viewBox1: UIView!
    @IBOutlet weak var viewBox2: UIView!
    @IBOutlet weak var viewBox3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //导航返回按钮样式
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //去除页脚
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //表格分割线颜色
        tableView.separatorColor = UIColor(white: 0, alpha: 0)
        
        viewBox0.layer.shadowOpacity = 0.2
        viewBox0.layer.shadowColor = UIColor.black.cgColor
        viewBox0.layer.shadowOffset = CGSize(width: 0, height:0)
        viewBox0.layer.cornerRadius = 5
        viewBox0.layer.shadowRadius = 3
        viewBox1.layer.shadowOpacity = 0.2
        viewBox1.layer.shadowColor = UIColor.black.cgColor
        viewBox1.layer.shadowOffset = CGSize(width: 0, height:0)
        viewBox1.layer.cornerRadius = 5
        viewBox1.layer.shadowRadius = 3
        viewBox2.layer.shadowOpacity = 0.2
        viewBox2.layer.shadowColor = UIColor.black.cgColor
        viewBox2.layer.shadowOffset = CGSize(width: 0, height:0)
        viewBox2.layer.cornerRadius = 5
        viewBox2.layer.shadowRadius = 3
        viewBox3.layer.shadowOpacity = 0.2
        viewBox3.layer.shadowColor = UIColor.black.cgColor
        viewBox3.layer.shadowOffset = CGSize(width: 0, height:0)
        viewBox3.layer.cornerRadius = 5
        viewBox3.layer.shadowRadius = 3
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "WithdrawLink", sender:self )//跳转到提现
        case 1:
            performSegue(withIdentifier: "BankCardLink", sender:self )//跳转到银行卡
        case 2:
            alert("努力建设中...")
        case 3:
            alert("努力建设中...")
        default:
            break
        }
    }
    
    
    
    @IBAction func RechargeLink(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "RechargeLink", sender:self )//跳转到充值
        
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
