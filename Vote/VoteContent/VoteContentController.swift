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
    
    //MARK: Propeties
    var listsTitle: Array<String>!
    var listsAnswer: Array<String>!
    var type: Array<String>!
    var voteTitlte = ""
    var index = 0
    var currentPage: Int = 0
    
    
    var arraycontant = [Array<Any>]()//用于接收数据
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
        
    func reloadUI(_ array:Array<Any>) -> Void {//数据请求成功赋值
        arraycontant = array as! Array
        view.setNeedsLayout()//刷新页面
        
        //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    [manager GET:@"https://www.bingowo.com/api/index.php/article/question?question_id=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSData *arrayJson = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL];
        //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:arrayJson options:0 error:nil];
        //        NSDictionary *data = dict[@"data"];
        //        NSArray *content = data[@"content"];
        //        NSLog(@"%@", content[0]);
        //
        //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        //    }];

    }
    
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
        self.listsTitle = ["标题1", "标题2"];
        self.listsAnswer = ["答案1", "答案2"];
        self.type = ["type1", "type2"];
        if let startVc = vc(atIndex: 0) {
            setViewControllers([startVc], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
