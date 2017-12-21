//
//  NavigationTableView.swift
//  Vote
//
//  Created by 林以达 on 2017/11/17.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NavigationTableView: UITableViewController {

    //MARK: Properties
    var index = 0
    var vote = [["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"], ["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"], ["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"], ["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thread.sleep(forTimeInterval: 1.5)//启动图延长时间设置

//        switch index {
//        case 0:
//            vote = [["为了有效的提高科研人员的文献检索效率，因此将该应用分为文献搜索模块", "2¥", "2017-11-17","2017-11-27"], ["理解能力题型与虚实相应法应用，因此将该应用分为文献搜索模块", "2¥", "2017-11-17","2017-11-27"], ["亲情友情类文章与阅读分析", "2¥", "2017-11-17","2017-11-27"], ["为了有效的提高科研人员的文献检索效率，因此将该应用分为文献搜索模块", "2¥", "2017-11-17","2017-11-27"]]
//        case 1:
//            vote = [["理解能力题型与虚实相应法应用", "2¥", "2017-11-17","2017-11-27"], ["古诗文赏析题型与要点分析", "2¥", "2017-11-17","2017-11-27"], ["文言文题型与学习要点分析", "2¥", "2017-11-17","2017-11-27"], ["判定分析题型答题结构与要点分析", "2¥", "2017-11-17","2017-11-27"]]
//        case 2:
//            vote = [["“微学术”安卓移动应用是一款功能强大，操作简便，查询迅速快捷的文献检索类相关应用。其核心包含三大模块，即：文献搜索模块，文献管理模块，用户交流管理模块", "2¥", "2017-11-17","2017-11-27"], ["为了有效的提高科研人员的文献检索效率，因此将该应用分为文献搜索模块", "2¥", "2017-11-17","2017-11-27"], ["明天星期几明天星期几明天星期几明天星期几明天星期几", "2¥", "2017-11-17","2017-11-27"], ["明天星期几明天星期几明天星期几明天星期几明天星期几", "2¥", "2017-11-17","2017-11-27"]]
//        case 3:
//            vote = [["安全卫生知识普查", "2¥", "2017-11-17","2017-11-27"], ["安全卫生知识普查", "2¥", "2017-11-17","2017-11-27"], ["安全卫生知识普查", "2¥", "2017-11-17","2017-11-27"], ["安全卫生知识普查", "2¥", "2017-11-17","2017-11-27"]]
//        default:
//            break
//        }
        
        tableView.separatorColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
//        tableView.estimatedRowHeight = 36
//        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let parameters:Dictionary = ["type":index]
        let headers: HTTPHeaders = ["Accept": "application/json"]
        Alamofire.request("https://www.bingowo.com/api/index.php/article/index", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json["data"][0]["title"])
                    for (key,value) in json["data"].enumerated() {
                        //print(json["data"][key]["title"].string!)
                        var voteData = [json["data"][key]["title"].string!, json["data"][key]["num"].string!, json["data"][key]["time"].string!]
                        //print(voteData)
                        self.vote.append(voteData)
                        
                    }
                    print(self.vote)
                }
            case false:
                print(response.result.error ?? "")
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vote.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VoteListsCell
       
        //设置辩题行间距
        let voteTitle = vote[indexPath.row][0]//标题内容
        let lineheight = NSMutableParagraphStyle()
        lineheight.lineSpacing = 10
        let attributes = [NSAttributedStringKey.paragraphStyle: lineheight]
        cell.voteTitle.attributedText = NSAttributedString(string:"\(voteTitle)", attributes: attributes)

       // cell.voteTitle.text = vote[indexPath.row][0]
        
        cell.votePrice.text = vote[indexPath.row][1]
        cell.voteTime.text = "\(vote[indexPath.row][2])"
        
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shwoVoteContent" {
            let dest = segue.destination as! VoteContentController
            dest.voteTitlte = vote[(tableView.indexPathForSelectedRow?.row)!][0]
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        
    }

}
