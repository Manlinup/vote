//
//  UserInformationEditingThreeViewController.swift
//  Vote
//
//  Created by mc on 2017/12/5.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class UserInformationEditingThreeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var determinebtn: UIButton!//确定按钮
    @IBOutlet weak var cancelbtn: UIButton!//取消按钮
    @IBOutlet weak var titletext: UILabel!//标题
    @IBOutlet weak var pickerviewbg: UIView!//选项背景

    var pickerView:UIPickerView!
    
    var array = ["00后","90后","80后","70后","60后","50后","40后","30后","20后"]
    var array2 = ["男","女"]
    var bustarray = [String]()//胸围
    var heightarray = [String]()//身高
    var bodyweightarray = [String]()//体重
    var Educationarray = ["博士后","博士研究生","硕士研究生","本科","专科","高中","初中","小学","其它"]
    
    var munbertype:Int = 0 //监听是从哪个选项进入
    var selectText = "" //获取跳转前内容用于设置初始值及监听内容变化
    var savetext:String?//用于存储
    var index = 0 // 用于设置初始值
    
    
    func arraynumber( _ number:Int,unit:String) -> Array<Any> {
        var array = [String]()
        for i in 0..<number{
            array.append("\(i)\(unit)")
        }
        return array
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        
        //将dataSource设置成自己
        pickerView.dataSource = self
//        //将delegate设置成自己
        pickerView.delegate = self
        
        print(munbertype)
        
        bustarray = arraynumber(200, unit: "CM") as! [String]//胸围数据
        bodyweightarray = arraynumber(300, unit: "KG") as! [String]//体重数据
        heightarray = arraynumber(250, unit: "CM") as! [String] //身高数据
        
        //munbertype 1.头像 2.昵称 3.性别 4.年龄 5.签名 6.行业 7.公司 8.家乡 9.爱好 10.姓名 11.胸围  12.体重 13.身高  14.学历  15.院校  16.专业
        //循环匹配获取对应下标（设置选择框的默认值）/设置标题
        if(munbertype == 3){
               titletext.text = "性别"
                for i in 0..<array2.count{
                    if(selectText == array2[i]){
                        index = i
                    }
                }
        } else if(munbertype == 4){
                titletext.text = "年龄"
                for i in 0..<array.count{
                    if(selectText == array[i]){
                        index = i
                    }
                }
        }else if(munbertype == 11){
            titletext.text = "胸围"
            for i in 0..<bustarray.count{
                if(selectText == bustarray[i]){
                    index = i
                }
            }
        }else if(munbertype == 12){
            titletext.text = "体重"
            for i in 0..<bodyweightarray.count{
                if(selectText == bodyweightarray[i]){
                    index = i
                }
            }
        }else if(munbertype == 13){
            titletext.text = "身高"
            for i in 0..<heightarray.count{
                if(selectText == heightarray[i]){
                    index = i
                }
            }
        } else if(munbertype == 14){
            titletext.text = "学历"
            for i in 0..<Educationarray.count{
                if(selectText == Educationarray[i]){
                    index = i
                }
            }
        }
        print(index)
        //设置初始值
        if !selectText.isEqual("") {
            pickerView.selectRow(index,inComponent:0,animated:true)
        } else {
            pickerView.selectRow(0,inComponent:0,animated:true)
        }
        
        self.pickerviewbg.addSubview(pickerView)
        
        //设置约束
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        let c1 =  NSLayoutConstraint(
            item: pickerView,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: pickerviewbg,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant:0
        )
        
        let c2 =  NSLayoutConstraint(
            item: pickerView,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: pickerviewbg,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant:0
        )
        let c3 =  NSLayoutConstraint(
            item: pickerView,
            attribute: NSLayoutAttribute.leading,
            relatedBy: NSLayoutRelation.equal,
            toItem: pickerviewbg,
            attribute: NSLayoutAttribute.leading,
            multiplier: 1,
            constant:0
        )
        let c4 =  NSLayoutConstraint(
            item: pickerView,
            attribute: NSLayoutAttribute.trailing,
            relatedBy: NSLayoutRelation.equal,
            toItem: pickerviewbg,
            attribute: NSLayoutAttribute.trailing,
            multiplier: 1,
            constant:0
        )
        NSLayoutConstraint.activate([c1,c2,c3,c4])
    }
//    //设置选择框的列数为1列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        var int = 0
        if(munbertype == 3){
            int = array2.count
        } else if(munbertype == 4){
            int = array.count
        } else if(munbertype == 11){
            int = bustarray.count
        }else if(munbertype == 12){
            int = bodyweightarray.count
        }else if(munbertype == 13){
            int = heightarray.count
        } else if(munbertype == 14){
           int = Educationarray.count
        }
        return int
    }

    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        var text = ""
        if(munbertype == 3){
            text = self.array2[row]
        } else if(munbertype == 4){
            text = self.array[row]
        }else if(munbertype == 11){
            text = self.bustarray[row]
        }else if(munbertype == 12){
           text = self.bodyweightarray[row]
        }else if(munbertype == 13){
           text = self.heightarray[row]
        } else if(munbertype == 14){
           text = self.Educationarray[row]
        }
        return text
    }
    
    //获取选择框内容（滚动即触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(munbertype == 3){
            selectText = self.array2[row]
        } else if(munbertype == 4){
            selectText = self.array[row]
        }else if(munbertype == 11){
            selectText = self.bustarray[row]
        }else if(munbertype == 12){
            selectText = self.bodyweightarray[row]
        }else if(munbertype == 13){
            selectText = self.heightarray[row]
        } else if(munbertype == 14){
            selectText = self.Educationarray[row]
        }
        print(selectText)
    }
    
    
    //存储数据
    @IBAction func determinebtn(_ sender: UIButton) {
        getPickerViewValue()
    }
   
  func getPickerViewValue() {
        if !selectText.isEqual("") {
             savetext = selectText
        } else {
             // message = String(pickerView.selectedRow(inComponent: 0)) //触摸按钮时，获得被选中的索引
            if(munbertype == 3){
                savetext = self.array2[pickerView.selectedRow(inComponent: 0)]
            } else if(munbertype == 4){
                savetext = self.array[pickerView.selectedRow(inComponent: 0)]
            }else if(munbertype == 11){
                savetext = self.bustarray[pickerView.selectedRow(inComponent: 0)]
            }else if(munbertype == 12){
                savetext = self.bodyweightarray[pickerView.selectedRow(inComponent: 0)]
            } else if(munbertype == 13){
                savetext = self.heightarray[pickerView.selectedRow(inComponent: 0)]
            } else if(munbertype == 14){
                savetext = self.Educationarray[pickerView.selectedRow(inComponent: 0)]
            }
        }
    
        let alertController = UIAlertController(title: "更改为",
                                                message: savetext, preferredStyle: .alert)
        //let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .cancel){ (_) in
            switch (self.munbertype) {
            case 3:
                self.updateUserInfo(name: "sex", value: self.savetext!)
            case 4:
                self.updateUserInfo(name: "age", value: self.savetext!)
            case 11:
                self.updateUserInfo(name: "chest", value: self.savetext!)
            case 12:
                self.updateUserInfo(name: "weight", value: self.savetext!)
            case 13:
                self.updateUserInfo(name: "height", value: self.savetext!)
            case 14:
                self.updateUserInfo(name: "educational", value: self.savetext!)
            default:
                break
            }
        }
    
        alertController.addAction(okAction)
    
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUserInfo(name: String, value: String) {
        UserService().userEdit(name: name, value: value, failureHandler: { (reason, error) in
            VTAlert.alertSorryTips(message: error!.message, inViewController: self)
        }, completion: {user in
            self.performSegue(withIdentifier: "closeEditUserThree", sender:self )
        })
    }
}
