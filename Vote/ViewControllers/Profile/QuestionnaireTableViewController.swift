//
//  QuestionnaireTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class QuestionnaireTableViewController: UITableViewController,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //当用户点击搜索条或者该文字的时候调用这个方法
    }
    
    var search:UISearchController! //添加搜索条

    var title0 = ["数码家电产品满意度调研",
                  "餐厅服务需求调研",
                  "大学生消费情况调研",
                  "培训满意度调研",
                  "手机市场满意度调研",
                  "员工满意度调研",
                  "美妆产品满意度调研"]
    var num01 = ["88","1242","982","501","876","788","1083"]
    var mun02 = ["30","708","583","329","306","238","689",]
    var s = ["已完成","进行中","已完成","未发布","进行中","已完成","未发布"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // self.navigationItem.rightBarButtonItem = self.editButtonItem

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
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //将数据的条数循环上表格（表格行数）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title0.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionnaireCell", for: indexPath) as! QuestionnaireTableViewCell
            cell.title.text = title0[indexPath.row]
            cell.schedule.text = mun02[indexPath.row]
            cell.total.text = num01[indexPath.row]
            cell.status.text = s[indexPath.row]
        if(s[indexPath.row] == "已完成"){
            cell.styleone.backgroundColor = UIColor.init(red: 123/255, green: 189/255, blue: 36/255, alpha: 1.0)
            cell.styletwo.backgroundColor = UIColor.init(red: 123/255, green: 189/255, blue: 36/255, alpha: 1.0)
        } else if (s[indexPath.row] == "进行中"){
            cell.styleone.backgroundColor = UIColor.init(red: 239/255, green: 184/255, blue: 53/255, alpha: 1.0)
            cell.styletwo.backgroundColor = UIColor.init(red: 239/255, green: 184/255, blue: 53/255, alpha: 1.0)
        } else {
            cell.styleone.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 239/255, alpha: 1.0)
            cell.styletwo.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 239/255, alpha: 1.0)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)//点击完成取消行高亮
            performSegue(withIdentifier: "QuestionnaireDetailsLink", sender:self )//跳转到详情

    }
    
    var index:Int?
    override  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        index = indexPath.row
        return indexPath
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionnaireDetailsLink" {
            let data = segue.destination as! QuestionnaireDetailsTableViewController
            data.navtitle = title0[index!]//title0[tableView.indexPathForSelectedRow!.row]
            data.statustext = s[index!]
        }
    }
   

}
