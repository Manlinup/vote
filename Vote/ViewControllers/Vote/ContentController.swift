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
    
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectButton: UIButton!
    
    var index = 0
    var type = "0"
    var vcControl: VoteContentController!
    
    var vote: Vote?
    var selectValues: [Int : Any]!
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNav()
        initData()
        refreshUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Init
    private func initNav() {
        if let size = vote?.article?.length {
            titleLabel.text = "\(self.index+1)/\(size)"
        }
    }
    
    private func initData() {
        // do nothing
    }
    
    func refreshUI() {
        voteSort.text = "第\(index + 1)题"
        
        if let length = vote?.article?.length {
            voteNum.text = "共\(length)题"
        }
        
        if let title = vote?.article?.title {
            voteTitle.text = title
        }
        
        guard let question = vote?.questions![index] else {
            return
        }
        
        voteTitlteSelected.text = question.title
        
        guard let choices = question.choices else {
            return
        }
        
        var i = 0
        
        for c in ["A", "B", "C", "D"] {
            let choice = getChoice(string: c, choices: choices)
            
            switch (c) {
            case "A":
                selcetA.isHidden = (choice == nil)
                btnA.isHidden = (choice == nil)
                if choice != nil {
                    selcetA.text = "A. \(choice!.c_val ?? "")"
                    btnA.tag = choice!.id!
                }
                
            case "B":
                selcetB.isHidden = (choice == nil)
                btnB.isHidden = (choice == nil)
                if choice != nil {
                    selcetB.text = "B. \(choice!.c_val ?? "")"
                    btnB.tag = choice!.id!
                }
            case "C":
                selcetC.isHidden = (choice == nil)
                btnC.isHidden = (choice == nil)
                if choice != nil {
                    selcetC.text = "C. \(choice!.c_val ?? "")"
                    btnC.tag = choice!.id!
                }
            case "D":
                selcetD.isHidden = (choice == nil)
                btnD.isHidden = (choice == nil)
                if choice != nil {
                    selcetD.text = "D. \(choice!.c_val ?? "")"
                    btnD.tag = choice!.id!
                }
            default:
                break
            }
            
            i += i
        }
        
        setupSelectChoice()
    }
    
    private func setupSelectChoice() {
        guard let question = vote?.questions![index] else {
            return
        }
        
        if let choiceId = selectValues[question.id!] as? Int {
            let selectBtn = view.viewWithTag(choiceId) as! UIButton
            if self.selectButton != selectBtn {
                selectButton = selectBtn
                selectBtn.backgroundColor = selectedcolor
                selectBtn.isSelected = true
            }
        }
    }
    
    private func getChoice(string: String,  choices: [Choice]) -> Choice? {
        for c in choices {
            if string == c.c_num {
                return c
            }
        }
        
        return nil
    }

    var normlcolr = UIColor.init(red: 214/255, green: 215/255, blue: 220/255, alpha: 1.0)//选中颜色
    var selectedcolor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)//常规颜色
    
    @IBAction func selcetbtn(_ sender: UIButton) {
        if selectButton == sender {
            selectButton = nil
            sender.isSelected = false
            sender.backgroundColor = normlcolr
            
            if let question = vote?.questions![index] {
                selectValues.removeValue(forKey: question.id!)
            }
        
        } else {
            if let btn = selectButton {
                btn.isSelected = false
                btn.backgroundColor = normlcolr
            }
            
            selectButton = sender
            sender.isSelected = true
            sender.backgroundColor = selectedcolor
            
            if let question = vote?.questions![index] {
                selectValues[question.id!] = sender.tag
            }
            
            if selectValues.count == self.vote?.questions?.count {
                alert2("最后一题了,请点击保存")
            }
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

