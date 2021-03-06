//
//  SurveyTarget01TableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/20.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class SurveyTarget01TableViewController: UITableViewController {
    var  object01 = ["学生", "白领", "工人","其他"]
    var saveText: String!
    
    var delegate: PutMainTableControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)//导航返回按钮样式
        //去除页脚
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // 表格分割线颜色
        tableView.separatorColor = UIColor(white:0, alpha: 0)
        
        self.title = "回答人群"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object01.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyTarget01Cell", for: indexPath) as! SurveyTarget01TableViewCell
            cell.labeltext.text = object01[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)//点击完成取消行高亮
//        performSegue(withIdentifier: "SurveyTargetLink02", sender:self )//转场下一页
        saveText = object01[indexPath.row]
        if let delegate = delegate {
            delegate.updateSurveyTarget(text: saveText)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var index:Int?
    override  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        index = indexPath.row
        return indexPath
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SurveyTargetLink02" {
            let data = segue.destination as! SurveyTarget02TableViewController
            data.selectText = object01[index!]

        }
    }
}
