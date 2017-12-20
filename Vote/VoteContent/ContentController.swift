//
//  ViewController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class ContentController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var voteTitle: UILabel!
    @IBOutlet weak var voteSort: UILabel!
    @IBOutlet weak var voteNum: UILabel!
    @IBOutlet weak var voteTitlteSelected: UILabel!
    @IBOutlet weak var selcetA: UILabel!//A
    @IBOutlet weak var selcetB: UILabel! //B
    @IBOutlet weak var selcetC: UILabel!//C
    @IBOutlet weak var selcetD: UILabel!//D
    @IBOutlet weak var backBtn: UIButton!//保存按钮
    
    var isBtnSelected = false
    
    var index = 0
    var titleTop = ""
    var titleSelected = ""
    var selected = ""
    var listCount = 0
    var vcControl: VoteContentController!
    var type = "0"
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bgView.layer.shadowColor = UIColor.black
        //bgView.layer.shadowOffset = CGSize(width: 10, height: 10)
        //bgView.layer.shadowPath
       
        voteNum.text = "共\(listCount)题"
        voteSort.text = "第\(index + 1)题"
        
        let voteTitlteSelectedtext = "\(index + 1) \(titleSelected)"//题目标题内容
        //一下为设置题目行高并添加内容
        let lineheight = NSMutableParagraphStyle()
        lineheight.lineSpacing = 10
        let attributes = [NSAttributedStringKey.paragraphStyle: lineheight]
        voteTitlteSelected.attributedText = NSAttributedString(string:"\(voteTitlteSelectedtext)", attributes: attributes)
       // voteTitlteSelected.text = "\(index + 1) \(titleSelected)"
        
        selcetA.text = selected
        
        voteTitle.text = titleTop


        backBtn.isHidden = (index != 3)//当不在做后一道答题时保存按钮隐藏
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var normlcolr = UIColor.init(red: 214/255, green: 215/255, blue: 220/255, alpha: 1.0)//选中颜色
    var selectedcolor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)//常规颜色
    
    @IBAction func selcetbtn(_ sender: UIButton) {//选择按钮
        if type == "1"{//单选
            if isBtnSelected {
                return
            }
            isBtnSelected = true
            sender.backgroundColor = selectedcolor //选中颜色
            sender.isSelected = true
        }
        if type == "2"{//多选
            sender.backgroundColor = selectedcolor //选中颜色
            sender.isSelected = true
        }
        
            if (index + 1) == listCount {
                alert2("最后一题了,请点击保存")
            }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {//保存按钮
        let ac = UIAlertController(title: "您的投票还未保存！", message: "保存到草稿吗？", preferredStyle: .alert)
        let option1 = UIAlertAction(title: "保存", style: .default){
            (_) in
            self.alert("保存成功")
        }
        let option2 = UIAlertAction(title: "不，谢谢", style: .cancel) { (_) in
            self.performSegue(withIdentifier: "unwindToMain", sender: self)
        }
        ac.addAction(option1)
        ac.addAction(option2)
        self.present(ac, animated: true, completion: nil)
    }
    
    
    func alertsheet(_ title:String){//分享弹框
        let action = UIAlertController(title:title, message:nil , preferredStyle:.actionSheet )
        let op = UIAlertAction(title: "分享到微信", style:.default, handler: nil)
        let op2 = UIAlertAction(title: "分享到QQ", style:.default, handler: nil)
        let op3 = UIAlertAction(title: "返回", style: .cancel) { (_) in
              self.performSegue(withIdentifier: "unwindToMain", sender: self)
        }
        action.addAction(op)
        action.addAction(op2)
        action.addAction(op3)
        self.present(action, animated: true, completion: nil)
    }

    func alert(_ alerttext:String){//提示/弹框
        let munt = UIAlertController(title:alerttext, message: nil, preferredStyle: .alert)
        self.present(munt, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){//设置弹框显示时间
            self.presentedViewController?.dismiss(animated: false) {
                self.alertsheet("答题完成,分享给更多人")
            }
        }
    }
    func alert2(_ alerttext:String){//提示2/弹框
        let munt = UIAlertController(title:alerttext, message: nil, preferredStyle: .alert)
        self.present(munt, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){//设置弹框显示时间
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }

}

