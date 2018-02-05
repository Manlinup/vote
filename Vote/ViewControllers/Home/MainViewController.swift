//
//  MainViewController.swift
//  Vote
//
//  Created by 林以达 on 2017/11/17.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    fileprivate var selectedIndex: Int = 0
    fileprivate var tags = ["热门", "品牌", "社会", "免费"]
    
    fileprivate lazy var menuView : MenuButtonView = {
        let view  = MenuButtonView()
        view.backgroundColor = UIColor.clear
        view.delegate = self
        
        return view
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.vtViewBackgroundColor()
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        makeUI()
        setupViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Init
    private func initData() {
        menuView.titleArray = tags
    }
    
    private func makeUI() {
        scrollView.contentSize = CGSize(width: CGFloat(menuView.titleArray.count) * kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 156 - 50)
        scrollView.backgroundColor = UIColor.clear
        
        view.addSubview(menuView)
        view.addSubview(scrollView)
        
        delay(0.1) {
            for index in 0..<self.tags.count {
                if let contentVc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationTableView") as? NavigationTableView {
                    contentVc.index = index
                    
                    self.setupOrderController(vc: contentVc, index: index)
                }
            }
        }
    }
    
    private func setupOrderController(vc: NavigationTableView, index: Int) {
        vc.view.frame = CGRect(x: kSCREEN_WIDTH * CGFloat(index), y: 0, width: kSCREEN_WIDTH, height: scrollView.contentSize.height)
        
        self.addChildViewController(vc)
        scrollView.addSubview(vc.view)
    }
    
    func setupViewConstraints() {
        menuView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(156)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(menuView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
}

extension MainViewController: MenuButtonViewDelegate, UIScrollViewDelegate {
    func clickButton(button: UIButton) {
        let index : CGFloat = CGFloat(button.tag - 100)
        self.scrollView.contentOffset = CGPoint(x: index * kSCREEN_WIDTH, y: 0)
        
        selectedIndex = Int(index)
    }
    
    // UIScrollView delegate method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.scrollView.isEqual(scrollView) {
            let index = Int((scrollView.contentOffset.x) / kSCREEN_WIDTH)
            log.debug(index)
            for subView in (self.menuView.subviews) {
                if subView.isKind(of: UIButton.classForCoder()) {
                    
                    if index == subView.tag - 100 {
                        self.menuView.selectMenuAction(index: index)
                    }
                }
            }
        }
    }
}
