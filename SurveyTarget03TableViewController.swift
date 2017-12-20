//
//  SurveyTarget03TableViewController.swift
//  Vote
//
//  Created by mc on 2017/12/20.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class SurveyTarget03TableViewController: UITableViewController {


    @IBOutlet weak var closebtn: UIButton!//关闭按钮需要隐藏
    @IBOutlet weak var done: UIBarButtonItem!
    var selectText = ""
    var saveText:String?
    var  object01 = ["哈哈0001","哈哈0002","哈哈0003","哈哈0004","哈哈0005","哈哈0006"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("\(selectText)")
        
        closebtn.isHidden = true//隐藏关闭按钮
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)//导航返回按钮样式
        //去除页脚
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // 表格分割线颜色
        tableView.separatorColor = UIColor(white:0, alpha: 0)
        
        self.title = "回答人群"
        
        done.isEnabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return object01.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyTarget03Cell", for: indexPath) as! SurveyTarget03TableViewCell
        
        cell.labeltext.text = object01[indexPath.row]
        return cell
    }

    
    var index:Int?
    override  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        index = indexPath.row
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)//点击完成取消行高亮
        done.isEnabled = true
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if index != nil {
            saveText = "\(selectText)-\(object01[index!])"
            performSegue(withIdentifier: "closeSurveyTargetlast", sender:self )
        }
    }
    
   

}
