//
//  VoteContentController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VoteContentController: UIPageViewController, UIPageViewControllerDataSource {
    var voteTitlte = ""
    var index = 0
    var questionId: Int = 0
    var currentPage = 0
    var selectValues: [Int : Any]!
    
    var vote: Vote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Init
    private func initData() {
        ArticleService().getQuestions(id: questionId, failureHandler: { (reason, error) in
            VTAlert.alertSorry(message: error?.message, inViewController: self)
        }, completion: {vote in
            self.vote = vote
            self.makeUI()
        })
    }
    
//    private func refreshNav() {
//        if let size = vote?.article?.length {
//            navigationItem.title = "\(index+1)/\(size)"
//        }
//    }
    
    private func makeUI() {
        dataSource = self
        
        if let startVc = vc(atIndex: 0) {
            startVc.selectValues = [Int : Any]()
            
            setViewControllers([startVc], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: Action
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getBeforeViewController(currentVC: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getAfterViewController(currentVC: viewController)
    }
    
    func getBeforeViewController(currentVC: UIViewController) -> ContentController? {
        let currentVC = currentVC as! ContentController
        currentPage = currentVC.index - 1
        
        if let nextVC = vc(atIndex: currentPage) {
            nextVC.selectValues = currentVC.selectValues
            self.selectValues = currentVC.selectValues
            
            return nextVC
        }
        
        return nil
    }
    
    func getAfterViewController(currentVC: UIViewController) -> ContentController? {
        let currentVC = currentVC as! ContentController
        currentPage = currentVC.index + 1
        
        if let nextVC = vc(atIndex: currentPage) {
            nextVC.selectValues = currentVC.selectValues
            self.selectValues = currentVC.selectValues
            
            return nextVC
        }
        
        return nil
    }
    
    func vc(atIndex: Int) -> ContentController? {
        guard let length = vote?.article?.length else {
            return nil
        }
        
        guard atIndex >= 0 && atIndex < length else {
            return nil
        }
        
        if let contentVc = storyboard?.instantiateViewController(withIdentifier: "ContentController") as? ContentController {
            contentVc.index = currentPage
            contentVc.vote = self.vote
            
            return contentVc
        }
        
        return nil
    }
    
    @IBAction func savaBtn(_ sender: UIBarButtonItem) {
        if sender.title == "保存" {
            performSegue(withIdentifier: "unwindToMain", sender: self)
        } 
    }
    
    func close() {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}
