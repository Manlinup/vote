//
//  ViewController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit
import Alamofire

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
    var type = "0"
    var vcControl: VoteContentController!

    var questionArray = Array<XYDVoteContentModel>()
    
    //从首页传递一个question_id。每个问卷都有一个相应的id
    var question_id = 4
    
    
    
    
    
    
    //Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fatchedAlldata()
    }
    
    func fatchedAlldata() {//获取数据
        let parameters:Dictionary = ["question_id":question_id]
        let headers: HTTPHeaders = ["Accept": "application/json"]
        Alamofire.request("https://www.bingowo.com/api/index.php/article/question", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    //JSON Data
                    guard let data = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) else { return }
                    let testJson = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let jsonDict = testJson as? NSDictionary {
                        if let data_1 = jsonDict["data"] as? NSDictionary {
                            if let content = data_1["content"] as? NSArray {
                                var contentArray = Array<XYDVoteContentModel>()
                                for i in 0..<content.count {
                                    if let questionInfo = content[i] as? NSDictionary {
                                        let contentInfo: XYDVoteContentModel = XYDVoteContentModel()
                                        contentInfo.title = questionInfo["title"] as? String
                                        if let optionArray = questionInfo["choose"] as? NSArray {
                                            var options = Array<XYDVoteOptionModel>()
                                            for j in 0..<optionArray.count {
                                                if let optionInfo = optionArray[j] as? NSDictionary {
                                                    let optionsInfo: XYDVoteOptionModel = XYDVoteOptionModel();
                                                    optionsInfo.optionTitle = optionInfo["c_val"] as? String
                                                    options.append(optionsInfo)
                                                }
                                            }
                                            contentInfo.options = options
                                        }
                                        contentArray.append(contentInfo)
                                    }
                                }
                                self.questionArray = contentArray
                                self.reloadUI()
                            }
                        }
                    }
                }
            case false:
                print(response.result.error ?? "")
            }
        }
    }
    
    func reloadUI() {
        if self.questionArray.count > 0 {
            let questionInfo = self.questionArray[index]
            voteNum.text = "共\(self.questionArray.count)题"
            voteSort.text = "第\(index + 1)题"
            
            let lineheight = NSMutableParagraphStyle()
            lineheight.lineSpacing = 10
            let attributes = [NSAttributedStringKey.paragraphStyle: lineheight]
            voteTitlteSelected.attributedText = NSAttributedString(string:"\(questionInfo.title ?? "")", attributes: attributes)
            
            for i in 0..<questionInfo.options.count {
                let optionInfo = questionInfo.options[i]
                if i == 0 {
                    self.selcetA.text = optionInfo.optionTitle
                }
                if i == 1 {
                    self.selcetB.text = optionInfo.optionTitle
                }
                if i == 2 {
                    self.selcetC.text = optionInfo.optionTitle
                }
                if i == 3 {
                    self.selcetD.text = optionInfo.optionTitle
                }
            }
        }
    }

    
    
    
    
    //Other

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
        
            if (index + 1) == self.questionArray.count {
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

