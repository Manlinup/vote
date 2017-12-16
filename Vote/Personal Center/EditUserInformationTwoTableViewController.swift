//
//  EditUserInformationTwoTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/29.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class EditUserInformationTwoTableViewController: UITableViewController {

    var industry = ["互联网","家装","金融","营销","贸易","家政服务","法律","旅游"]
    var hometown = ["北京","上海","天津","重庆","香港","澳门","广东","四川","浙江","福建","台湾","广西","黑龙江","吉林","辽宁","内蒙古","新疆","西藏","青海","甘肃","河北","河南","湖南","湖北","江苏","安徽"]

    var munbertype:Int = 0 //用监听从哪个栏目进入
    var selectText = "" ////获取跳转前内容用于设置初始值及监听内容变化
    var selectTexttwo = "" ////获取跳转前内容用于设置初始值及监听内容变化
    var savetext:String? //用于数据存储
    let udname = UserDefaultsKey.personalinformation()//获取UserDefaults名称
   
    @IBOutlet weak var currentlocation: UILabel!//当前
    @IBOutlet weak var selected: UILabel!//已选
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //去除页脚
        tableView.tableFooterView = UIView(frame: CGRect.zero)
       // 表格分割线颜色
        tableView.separatorColor = UIColor(white:0, alpha: 0)
        let defalts = UserDefaults.standard
        //munbertype监听是那个栏目进来的  6.行业  8.家乡
        munbertype = defalts.integer(forKey:udname.munbertype)
        //获取已选中的内容
        selectText = defalts.string(forKey:udname.homeindustry)!
        selectTexttwo = selectText
        
        print(selectText)
        
        if (munbertype == 6){//标题
            self.title = "编辑行业"
            currentlocation.text = "当前行业："
            selected.text = selectText //当前行业
        }else if(munbertype == 8){
             self.title = "编辑家乡"
             currentlocation.text = "当前家乡："
             selected.text = selectText //当前行业
        }
    }
    
  /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
     }
   */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//单元格选中事件
        //tableView.deselectRow(at: indexPath, animated: true)//点击完成取消行高亮
        print("你点几了",indexPath.section,"组",indexPath.row,"行")
        if (munbertype == 6){//行
            //获取选中内容
            selectText = self.industry[indexPath.row]
        }else if(munbertype == 8){//家乡
            selectText = self.hometown[indexPath.row]
        }
    }
    //数据行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var int = 0
        if (munbertype == 6){
            int = industry.count
        }else if(munbertype == 8){
            int = hometown.count
        }
        return int
    }
   
     //单元格内容填充
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "EditUserInformationTwoCell", for: indexPath) as! EditUserInformationTwoTableViewCell
            if (munbertype == 6){//行业
                cell.labeltext.text = industry[indexPath.row]
            }else if(munbertype == 8){//家乡
                 cell.labeltext.text = hometown[indexPath.row]
            }
         return cell
     }
  
    
    @IBAction func save(_ sender: UIBarButtonItem) {//存储数据
        if !selectText.isEqual("") && selectTexttwo != selectText{
            if(munbertype == 6){//行业
                savetext = selectText
                performSegue(withIdentifier:"closeEditUserTwo", sender: self)//转场
            } else if(munbertype == 8){//家乡
                savetext = selectText
                performSegue(withIdentifier:"closeEditUserTwo", sender: self)//转场
            }
        } else if selectTexttwo == selectText {
           alert("地址无改变")
        }
    }
    

    func alert(_ alerttext:String){//弹框
        let alertController = UIAlertController(title: "提示",
                                        message:alerttext, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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

}
