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
    
    
    var munbertype:Int = 0 //监听是从哪个选项进入
    var selectText = "" //获取跳转前内容用于设置初始值及监听内容变化
    var savetext:String?//用于存储
    var index = 0 // 用于设置初始值
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIPickerView()
        
        //将dataSource设置成自己
        pickerView.dataSource = self
//        //将delegate设置成自己
        pickerView.delegate = self
        
        print(munbertype)
        //munbertype 3.性别 5.年龄
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
        }
        return text
    }
    
    //获取选择框内容（滚动即触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(munbertype == 3){
            selectText = self.array2[row]
        } else if(munbertype == 4){
            selectText = self.array[row]
        }
        print(selectText)
    }
    
    
    @IBAction func determinebtn(_ sender: UIButton) {//存储数据
        
        getPickerViewValue()
        
    }
    
    
   
  func getPickerViewValue(){
    
        if !selectText.isEqual("") {
             savetext = selectText
        } else {
             // message = String(pickerView.selectedRow(inComponent: 0)) //触摸按钮时，获得被选中的索引
            if(munbertype == 3){
                savetext = self.array2[pickerView.selectedRow(inComponent: 0)]
            } else if(munbertype == 4){
                savetext = self.array[pickerView.selectedRow(inComponent: 0)]
            }
        }
    
        let alertController = UIAlertController(title: "更改为",
                                                message: savetext, preferredStyle: .alert)
        //let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .cancel){ (_) in
            
             self.performSegue(withIdentifier: "closeEditUserThree", sender:self )
        }
   
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
