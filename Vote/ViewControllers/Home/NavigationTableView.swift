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
  /*  var vote = [["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"], ["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"], ["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"], ["3年内护士消防知识测试", "2¥", "2017-11-17","2017-11-27"]]*/
   
    var vote = [Array<Any>]()
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
        
        startRefreshData()
    }
    
    func startRefreshData(){
        log.debug("request data index = \(self.index)")
        
        var array = [Array<Any>]()
        let parameters:Dictionary = ["type": index]
        let headers: HTTPHeaders = ["Accept": "application/json"]
        Alamofire.request("https://www.bingowo.com/api/index.php/article/index", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    log.debug(json)
                   // print(json["data"][0]["title"])
                    for (key,value) in json["data"].enumerated() {
                        //print(json["data"][key]["title"].string!)
                        var voteData = [json["data"][key]["title"].string!,
                                        json["data"][key]["price"].string!,
                                        json["data"][key]["time"].string!,
                                        json["data"][key]["question_id"].string!]
                        array.append(voteData)
                    }
                    self.reloadUI(array)
                }
            case false:
                print(response.result.error ?? "")
            }
        }
    }
    func reloadUI(_ array:Array<Any>) -> Void {
        vote = array as! Array
        mainAsync {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

        
        cell.votePrice.text = vote[indexPath.row][1] as? String
        cell.voteTime.text = "\(vote[indexPath.row][2])"
        
        return cell
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard checkLoginStatus() else { return }
    
        let voteVC = segue.destination as! VoteContentController
        if let questionId = vote[(tableView.indexPathForSelectedRow?.row)!][3] as? String {
            voteVC.questionId = Int(questionId)!
        }
        
        voteVC.voteTitlte = vote[(tableView.indexPathForSelectedRow?.row)!][0] as! String
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        
    }

}
