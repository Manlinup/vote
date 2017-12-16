//
//  UserInformationEditingTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class UserInformationEditingTableViewController: UITableViewController {

    @IBOutlet weak var nametext: UILabel!//昵称
    @IBOutlet weak var signaturetext: UILabel!//签名
    @IBOutlet weak var companytext: UILabel!//公司名称
    @IBOutlet weak var gendertext: UILabel!//性别
    @IBOutlet weak var yeartext: UILabel!//年龄
    @IBOutlet weak var industrytext: UILabel!//行业
    @IBOutlet weak var hometowntext: UILabel! //家乡
    
    let udname = UserDefaultsKey.personalinformation()//获取UserDefaults名称
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)//表格背景颜色
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine//分割线样式
        tableView.separatorColor = UIColor.init(red: 92/255, green: 94/255, blue: 102/255, alpha: 1.0)//表格分割线颜色
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)//导航返回按钮样式
        
    }
 
    var munbertype:Int = 0 //用于监听页面跳转
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//单元格选中事件
        tableView.deselectRow(at: indexPath, animated: true)//点击完成取消行高亮
        ///print("你点几了",indexPath.section,"组",indexPath.row,"行")
        
        
        if(indexPath.section == 0){
            
            switch(indexPath.row)
            {
            case 0:
                //头像
                 munbertype = 1
                performSegue(withIdentifier: "EditUserPhotoLink", sender:self )
                break
            case 1:
                //昵称
                 munbertype = 2
                 performSegue(withIdentifier: "UserInformationEditingOneLink", sender:self )
                break
            case 2:
                //性别
                munbertype = 3
                //mod()//转场函数
                 performSegue(withIdentifier: "UserInformationEditingThreeLink", sender:self )
                break
            case 3:
                //年龄
                 munbertype = 4
                 //mod()//转场函数
                 performSegue(withIdentifier: "UserInformationEditingThreeLink", sender:self )
                break
            case 4:
                //签名
                munbertype = 5
                performSegue(withIdentifier: "UserInformationEditingOneLink", sender:self )
                break
              
            default: break
               
            }
            
        }else if(indexPath.section == 1){
            switch(indexPath.row)
            {
            case 0:
                //行业
                munbertype = 6
                performSegue(withIdentifier: "UserInformationEditingTwoLink", sender:self )
                break
            case 1:
                //公司
                munbertype = 7
                performSegue(withIdentifier: "UserInformationEditingOneLink", sender:self )
                break
            default: break
                
            }
        }else{
            switch(indexPath.row)
            {
            case 0:
                //家乡
                munbertype = 8
                performSegue(withIdentifier: "UserInformationEditingTwoLink", sender:self )
                break
            case 1:
                //爱好
                munbertype = 9
                performSegue(withIdentifier: "UserInterestLink", sender:self )
                break
            default:break
            }
         }
        
        print("跳转前",munbertype)
        //munbertype 1.头像 2.昵称 3.性别 4.年龄 5.签名 6.行业 7.公司 8.家乡 9.爱好
        //保存数据到本地
        let defaults = UserDefaults.standard
        defaults.set(munbertype, forKey: udname.munbertype)
        if (munbertype == 2) {
            defaults.setValue(nametext.text!, forKey: udname.inputtext)
        } else if (munbertype == 5){
            defaults.setValue(signaturetext.text!, forKey: udname.inputtext)
        }else if (munbertype == 7){
             defaults.setValue(companytext.text!, forKey: udname.inputtext)
        }else if (munbertype == 6){
            defaults.setValue(industrytext.text!, forKey: udname.homeindustry)
        }else if (munbertype == 8){
            defaults.setValue(hometowntext.text!, forKey: udname.homeindustry)
        }
        
        
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {//表格与表格之间的颜色
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        return headerView
    }

    

//    func mod(){//性别/年龄转场
//        let viewController=storyboard?.instantiateViewController(withIdentifier: "userinformationpk") as! UserInformationEditingThreeViewController
//        viewController.munbertype = munbertype
//        if(munbertype == 3){
//            viewController.selectText = gendertext.text!
//        }else if(munbertype == 4){
//            viewController.selectText = yeartext.text!
//        }
//        viewController.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        viewController.modalPresentationStyle = .custom
//        self.present(viewController, animated: true, completion: nil)
//
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserInformationEditingThreeLink"{
           let info = segue.destination as! UserInformationEditingThreeViewController
           info.munbertype = munbertype
            if(munbertype == 3){
                info.selectText = gendertext.text!
            }else if(munbertype == 4){
                info.selectText = yeartext.text!
            }
           info.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            info.modalPresentationStyle = .custom
            
        }

    }
    
    @IBAction func closeudituserinformation(segue:UIStoryboardSegue){//用户信息编辑返向转场
        //munbertype 1.头像 2.昵称 3.性别 4.年龄 5.签名 6.行业 7.公司 8.家乡 9.爱好
        if segue.identifier == "closeEditUserOne"{
            let info1 = segue.source as! EditUserInformationOneViewController
            if let contanttext = info1.savetext{
                if(info1.munbertype == 2){//昵称
                    nametext.text = contanttext
                }else if(info1.munbertype == 5){//签名
                    signaturetext.text = contanttext
                }else if(info1.munbertype == 7){//公司
                    companytext.text = contanttext
                }
            }
        }
        if segue.identifier == "closeEditUserTwo"{
            let info2 = segue.source as! EditUserInformationTwoTableViewController
            if let selectText = info2.savetext {
                if(info2.munbertype == 6){//行业
                    industrytext.text = selectText
                }else if(info2.munbertype == 8){//家乡
                    hometowntext.text = selectText
                }
            }
            
        }
        if segue.identifier == "closeEditUserThree"{
            let info = segue.source as! UserInformationEditingThreeViewController
            if let selectText = info.savetext {
                if(info.munbertype == 3){//性别
                    gendertext.text = selectText
                }else if(info.munbertype == 4){//年龄
                    yeartext.text = selectText
                }
            }
            
        }
    }


}
