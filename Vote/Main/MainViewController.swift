//
//  MainViewController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/17.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var sliderView: UIView!
    
    
    //MARK: Properties
    var pageController: UIPageViewController!
    var sliderImageView: UIImageView!
    var index = 0
    var lastPage = 0
    var currentPage: Int = 0 {
        didSet {
            let offset = self.view.frame.width / 4.0 * CGFloat(currentPage)
            UIView.animate(withDuration: 0.3) {
                self.sliderImageView.frame.origin = CGPoint(x: offset, y: -1)
            }
            if currentPage > lastPage {
                self.pageController.setViewControllers([vc(atIndex: currentPage)!], direction: .forward, animated: false, completion: nil)
            } else {
                self.pageController.setViewControllers([vc(atIndex: currentPage)!], direction: .reverse, animated: false, completion: nil)
            }
            
            lastPage = currentPage
        }
    }
//    override var preferredStatusBarStyle:UIStatusBarStyle {//无导航条情况下设置状态栏
//        return .lightContent
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pageController = self.childViewControllers.first as! UIPageViewController
        
        pageController.dataSource = self
        
        if let startVc = vc(atIndex: 0) {
        pageController.setViewControllers([startVc], direction: .forward, animated: true, completion: nil)
        }
        
        sliderImage()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        index = (viewController as! NavigationTableView).index
        let offset = self.view.frame.width / 4.0 * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.sliderImageView.frame.origin = CGPoint(x: offset, y: -1)
        }
        index -= 1
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        index = (viewController as! NavigationTableView).index
        let offset = self.view.frame.width / 4.0 * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.sliderImageView.frame.origin = CGPoint(x: offset, y: -1)
        }
        index += 1
        return vc(atIndex: index)
    }
    
    func vc(atIndex: Int) -> NavigationTableView?{
        
        if case 0..<4 = atIndex {
            if let contentVc = storyboard?.instantiateViewController(withIdentifier: "NavigationTableView") as? NavigationTableView {
                contentVc.index = atIndex
                return contentVc
            }
        }
        return nil
    }

    func sliderImage() {
        sliderImageView = UIImageView(frame: CGRect(x: 0, y: -1, width: self.view.frame.width / 4.0, height: 3.0))
        sliderImageView.image = UIImage(named: "slider")
        sliderView.addSubview(sliderImageView)
    }
    
    @IBAction func changeNav(_ sender: UIButton) {
        
        currentPage = sender.tag - 101
    }
    
    @IBAction func closelogin(segue:UIStoryboardSegue){//登录返场
        
        print("到达主界面")
        
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
