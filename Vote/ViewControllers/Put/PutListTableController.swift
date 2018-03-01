//
//  PutListTableController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/15.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class PutListTableController: UITableViewController, UITextFieldDelegate {

    var voteAnswer: String?//接收谁来回答
    var voteNum: Int32?//接收问卷数量
    var QuestionnaireLength:Int32?//选题数量
    var unitprice:Double?//接收选题单价
    var voteDays: Int32?//接收周期
    var voteunitprice:Double?//接收问卷单价
    var voteFee: Double?//接收发布总价
    var voteName: String?//接收问卷标题
    
    @IBOutlet weak var votetitle: UILabel!//问卷标题
    
    
    var contant = [
                    ["您处于什么年龄阶段？","单选"],
                    ["您所在的城市是？","单选   "],
                    ["最近两个月您有随份子钱吗？","单选"],
                    ["您会如何”随份子“？","单选"],
                    ["您随过金额最高的份子钱是多少？","单选"],
                    ["份子钱让您有压力吗？","单选"],
                    ["你如何看待“随份子”？","多选"],
                    ["你会不会凭礼金多少定关系亲疏？","单选"],
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "编辑问卷"
        if voteName != nil {
             self.votetitle.text = "\(voteName!)"
//                print("接收谁来回答",voteAnswer!)
//                print("问卷数量",voteNum!)
//                print("选题数量",QuestionnaireLength!)
//                print("选题单价",unitprice!)
//                print("周期",voteDays!)
//                print("问卷单价",voteunitprice!)
//                print("发布总价",voteFee!)
        }
       
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
           self.alert("已提交，等待审核")
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
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    //MARK：actions
    func createTextFiled(_ obj: UITableViewCell) -> UITextField {
        let input = UITextField()
        
        
        return input
    }
    
}
