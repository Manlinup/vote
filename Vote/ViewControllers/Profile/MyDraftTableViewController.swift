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
                    ["儿童卫生情况调研","20","485","未发布"],
                    ["上海生活成本调研","203","865","未发布"],
                    ["白领旅行选择目的地调研","400","645","MI发布"],
                    ["维他奶市场满意度调研","1000","3465","未发布"],
                    ["彩票市场需求调研","50","300","未发布"],
                    ["地震防护注意事项调研","404","887","未发布"],
                    ["职场薪资待遇满意度调研","283","786","未发布"],
                    ["上线生鲜购买品类调研","486","982","未发布"],
                    ["武汉马拉松满意度调研","521","1002","未发布"],
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
