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
    var voteName: String?
    
    @IBOutlet weak var votetitle: UILabel!//问卷标题
    
    
    var contant = [
                    ["大浪淘沙","单选"],
                    ["你看过吉泽明步老师的拍的动作片吗？","多选"],
                    ["大浪淘沙","多选"],
                    ["大师教你卖关子","单选"],
                    ["嘻哈的特点","单选"],
                    ["陈冠希睡过几个女人","多选"],
                    ["你看过苍老师的拍的动作片吗？","单选"],
                    ["大浪淘沙","多选"],
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "编辑问卷"
        self.votetitle.text = "\(voteName!)"
        print(voteAnswer!)
        print(voteNum!)
        print(votePrice!)
        print(voteFee!)
        print(voteLength!)
        print(voteDays!)
        
        tableView.separatorColor = UIColor(white: 1, alpha: 0)
        self.clearsSelectionOnViewWillAppear = false

    
        tableView.separatorColor = UIColor(white: 0, alpha: 0)//表格分割线颜色
       
        
        //自定义导航系统返回按钮
        let leftBtn:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        leftBtn.image = #imageLiteral(resourceName: "retrunwhite")
        leftBtn.imageInsets = .init(top: 0, left: -30, bottom: -10, right: 0)
        leftBtn.tintColor=UIColor.white
        self.navigationItem.leftBarButtonItem = leftBtn
        
        
        ///导航发布按钮
        let rightBtn:UIBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.plain, target: self, action:#selector(releasevote))
        rightBtn.tintColor=UIColor.white
        self.navigationItem.rightBarButtonItem = rightBtn
    }
   
     @objc func back(){///返回方法
        let munto = UIAlertController(title:"提示", message: "是否放弃本次编辑", preferredStyle:.alert)
        let op = UIAlertAction(title: "确定", style: .cancel, handler: { (_) in
             self.navigationController?.popToRootViewController(animated: true)
        })
        let op2 = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        munto.addAction(op)
        munto.addAction(op2)
        self.present(munto, animated: true, completion: nil)
     }
    @objc func releasevote (){//发布方法
        alertsheet("支付或保存草稿")
    }
    
    func alertsheet(_ title:String){//分享弹框
        let action = UIAlertController(title:title, message:nil , preferredStyle:.actionSheet )
        let op = UIAlertAction(title: "支付发布", style:.default) { (_) in
           self.alert("努力建设中")
        }
        let op2 = UIAlertAction(title: "保存草稿", style:.default) { (_) in
            self.alert("已保存")
        }
        let op3 = UIAlertAction(title: "继续编辑", style: .cancel, handler: nil)
        action.addAction(op)
        action.addAction(op2)
        action.addAction(op3)
        self.present(action, animated: true, completion: nil)
    }
    
    func alert(_ alerttext:String){//提示弹框
        let munt = UIAlertController(title:alerttext, message: nil, preferredStyle: .alert)
        self.present(munt, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){//设置弹框显示时间
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contant.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PutListCell

           cell.topictitle.text = contant[indexPath.row][0]
           cell.topictype.text = contant[indexPath.row][1]
 
        return cell
    }
 
    //右滑事件========置顶，删除，分享
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //删除=====
        let del = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
                self.contant.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [del]
    }
    
    
    
    @IBAction func addQuestionnaire(_ sender: UIButton) {//跳转到添加问卷类型
        performSegue(withIdentifier: "AddQuestionnaireType", sender: self)
    }
    
    @IBAction func ModifyTheName(_ sender: UIButton) {//跳转到题目编辑页
        performSegue(withIdentifier: "EditQuestionnaireNameLink", sender:self )
    }
    
    @IBAction func retrunPutList(segue: UIStoryboardSegue){//返场
        
        
        
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
