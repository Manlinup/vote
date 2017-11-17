//
//  PutListTableController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/15.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class PutListTableController: UITableViewController, UITextFieldDelegate {

    var voteAnswer: String?
    var voteNum: Int?
    var votePrice: Int?
    var voteFee: Int?
    var voteLength: Int?
    var voteDays: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "添加问题"
        
        print(voteAnswer!)
        print(voteNum!)
        print(votePrice!)
        print(voteFee!)
        print(voteLength!)
        print(voteDays!)
        
        tableView.separatorColor = UIColor(white: 1, alpha: 0)
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return voteLength!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PutListCell

        // Configure the cell...
        
        cell.sortNum.text = String(indexPath.row + 1)
        
        return cell
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

    //MARK：actions
    func createTextFiled(_ obj: UITableViewCell) -> UITextField {
        let input = UITextField()
        
        
        return input
    }
    
}
