//
//  VoteContentController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class VoteContentController: UIPageViewController, UIPageViewControllerDataSource {
    
    //MARK: Propeties
    var listsTitle = ["发生火灾要及时报警，报警电话是?发生火灾要及时报警，报警电话是?发生火灾要及时报警，报警电话是?", "发生火灾要及时报警，报警电话是?", "发生火灾要及时报警，报警电话是?", "发生火灾要及时报警，报警电话是?"]
    var listsAnswer = ["A.免费翻译服务可提供简体中文和另外 100 多种语言之间的互译功能", "A 110   B 119   C 120", "A 110   B 119   C 120", "A 110   B 119"]
     var type = ["1", "2", "1", "2"]
    var voteTitlte = ""
    
    var index = 0
    var currentPage: Int = 0
    
    
    //MARK: Action
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        index = (viewController as! ContentController).index
        currentPage = index
        index -= 1
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        index = (viewController as! ContentController).index
        currentPage = index
        index += 1
        return vc(atIndex: index)
    }
    
    func vc(atIndex: Int) -> ContentController?{
        
        if case 0..<listsTitle.count = atIndex {
            if let contentVc = storyboard?.instantiateViewController(withIdentifier: "ContentController") as? ContentController {
                contentVc.index = atIndex
                contentVc.titleSelected = listsTitle[atIndex]
                contentVc.selected = listsAnswer[atIndex]
                contentVc.type = type[atIndex]
                contentVc.listCount = listsTitle.count
                contentVc.titleTop = voteTitlte
                return contentVc
            }
        }
        return nil
    }
    
    @IBAction func savaBtn(_ sender: UIBarButtonItem) {
        if sender.title == "保存" {
            performSegue(withIdentifier: "unwindToMain", sender: self)
        } 
    }
//    @IBAction func backBtn(_ sender: UIBarButtonItem) {
//        let ac = UIAlertController(title: "您的投票还未保存！", message: "保存到草稿吗？", preferredStyle: .alert)
//        let option1 = UIAlertAction(title: "保存", style: .default){
//            (_) in
//            self.performSegue(withIdentifier: "unwindToMain", sender: self)
//        }
//        let option2 = UIAlertAction(title: "不，谢谢", style: .cancel) { (_) in
//            self.performSegue(withIdentifier: "unwindToMain", sender: self)
//        }
//        ac.addAction(option1)
//        ac.addAction(option2)
//        self.present(ac, animated: true, completion: nil)
//    }
    
    func close() {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        navigationItem.title = voteTitlte
        
        if let startVc = vc(atIndex: 0) {
            setViewControllers([startVc], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
