//
//  MyDraftTableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/19.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class MyDraftTableViewController: UITableViewController ,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //当用户点击搜索条或者该文字的时候调用这个方法
    }
    var search:UISearchController! //添加搜索条

    var arrayp = [
                    ["活宝宝反腐败","233","4485","未发布"],
                    ["方式房舒服败","233","4465","未发布"],
                    ["那边的高富帅谁","233","4645","MI发布"],
                    ["干豆腐卷福的爽肤水","233","4465","未发布"],
                    ["的爽肤水谁说短发上","233","4465","未发布"],
                    ["非是奉公守法个是","233","4465","未发布"],
                    ["得过分过分是","233","4465","未发布"],
                    ["方法是舒服是发生房","233","4465","未发布"],
                    ["短发短发发的","233","445","未发布"],
                    ["地方发舒服","233","44335","未发布"]
                 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的草稿"
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)//导航返回按钮样式
        
        
        //搜索条
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        tableView.tableHeaderView = search.searchBar
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.placeholder = "请输入问卷标题"
        search.searchBar.searchBarStyle = .minimal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayp.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDraftCell", for: indexPath) as! MyDraftTableViewCell
        cell.draftitle.text = arrayp[indexPath.row][0]
        cell.nownumber.text = arrayp[indexPath.row][1]
        cell.maxnumber.text = arrayp[indexPath.row][2]
        cell.draftstatus.text = arrayp[indexPath.row][3]

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)//点击完成取消行高亮
        performSegue(withIdentifier: "showPutList02", sender: self)//跳转到添加问题列表
        
    }
    
    //右滑事件========置顶，删除，分享
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //删除=====
        let del = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            self.arrayp.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [del]
    }
    
    //此函数获取当前选中行下标
    var index:Int?
    override  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        index = indexPath.row
        return indexPath
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//转场传值
        if segue.identifier == "showPutList02" {
            let dest = segue.destination as! PutListTableController
            dest.voteName = arrayp[index!][0]//问卷标题
        }
    }
 

}
