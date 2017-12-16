//
//  BankCardTableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/10.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class BankCardTableViewController: UITableViewController {
    
    var bank = ["工行银行","建设银行","中国银行","农业银行","人民银行"]
    var banktype = ["储蓄卡","储蓄卡","信用卡","信用卡","储蓄卡"]
    var lastmunber = ["6467","4445","5666","6660","6644"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //去除页脚
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //表格分割线颜色
        tableView.separatorColor = UIColor(white: 0, alpha: 0)

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
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCardCell", for: indexPath) as! BankCardTableViewCell
        cell.bankname.text = bank[indexPath.row]//银行名称
        cell.cardtype.text = banktype[indexPath.row]//卡片类型
        cell.cardmunber.text = lastmunber[indexPath.row]//卡号后四位
        //cell.img.image = UIImage //银行logo
       

        return cell
    }
 
    @IBAction func AddBankCardLink(_ sender: UIBarButtonItem) {//跳转到添加银行卡
        performSegue(withIdentifier: "AddBankCardLink", sender: self)
    }
    
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
