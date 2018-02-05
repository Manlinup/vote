//
//  QuestionnaireDetailsTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class QuestionnaireDetailsTableViewController: UITableViewController {

    
    
    var navtitle = ""
    var statustext = ""
    
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var timeConsuming: UILabel!
    @IBOutlet weak var scheduleNum: UILabel!
    @IBOutlet weak var totalNum: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var style: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navtitle
        detailsTitle.text = navtitle
        status.text = statustext
    
        if(statustext == "已完成"){
            style.backgroundColor = UIColor.init(red: 123/255, green: 189/255, blue: 36/255, alpha: 1.0)
            style.backgroundColor = UIColor.init(red: 123/255, green: 189/255, blue: 36/255, alpha: 1.0)

        } else if (statustext == "进行中"){
            style.backgroundColor = UIColor.init(red: 239/255, green: 184/255, blue: 53/255, alpha: 1.0)
            style.backgroundColor = UIColor.init(red: 239/255, green: 184/255, blue: 53/255, alpha: 1.0)
        } else {
            style.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 239/255, alpha: 1.0)
            style.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 239/255, alpha: 1.0)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0, alpha: 0)//表格分割线颜色
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)//导航返回按钮样式
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
