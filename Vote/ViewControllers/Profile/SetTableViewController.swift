//
//  SetTableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/20.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class SetTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0, alpha: 0)//表格分割线颜色
    }

    
    @IBAction func getout(_ sender: UIButton) {//退出帐号
        alertsheet()//退出方法
        
    }
    
    func alertsheet(){//退出弹框
        let action = UIAlertController(title:nil, message:nil , preferredStyle:.actionSheet )
       
        let op = UIAlertAction(title: "退出", style: .default) { (_) in
            VUserDefaults.cleanAllData()
            //弹回登录界面
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                self.navigationController?.popToRootViewController(animated: false)
                appDelegate.showLogin()
            }
        }
        let op3 = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        action.addAction(op)
        action.addAction(op3)
        self.present(action, animated: true, completion: nil)
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
