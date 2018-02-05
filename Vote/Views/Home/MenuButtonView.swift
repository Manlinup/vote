//
//  MenuButtonScrollView.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/5.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

protocol MenuButtonViewDelegate : NSObjectProtocol {
    func clickButton(button: UIButton)
}

class MenuButtonView: UIView {
    weak var delegate : MenuButtonViewDelegate?
    private var colors = Dictionary<String,UIColor>()
    var titleArray : [String] = [String]()
    var styleColor: UIColor = UIColor.vtTintColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.refreshSubViewWithFrame()
    }
    
    func refreshSubViewWithFrame() {
        guard titleArray.count != 0 else {
            return
        }
        
        let buttonWidth = kSCREEN_WIDTH / CGFloat(titleArray.count)
        
        for i in 0...titleArray.count - 1 {
            let button = UIButton.init(frame: CGRect(x: CGFloat(i) * buttonWidth, y: 2, width: buttonWidth, height: 40))
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitle(titleArray[i], for: UIControlState.normal)
            button.tag = 100 + i
            
            // Default
            if button.tag == 100 {
                button.setTitleColor(styleColor, for: UIControlState.normal)
            }else{
                button.setTitleColor(UIColor.vtTextGrayColor(), for: UIControlState.normal)
            }
            
            button.addTarget(self, action: #selector(MenuButtonView.clickButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
        }
        
        let lineView = UIView.init(frame: CGRect(x: 0, y: 44 - 8, width: kSCREEN_WIDTH, height: 2))
        lineView.backgroundColor = UIColor.clear
        self.addSubview(lineView)
        
        self.bottomLine = UIView.init(frame: CGRect(x: 5, y: 44 - 8, width: buttonWidth - 10, height: 2))
        self.bottomLine!.backgroundColor = styleColor
        
        self.addSubview(self.bottomLine!)
    }
    
    @objc func clickButtonAction(sender: UIButton) {
        let index = sender.tag - 100
        UIView.animate(withDuration: 0.25) { () -> Void in
            self.bottomLine?.frame = CGRect(x: 5 + ((self.bottomLine?.frame.width)! + 10) * CGFloat(Float(index)), y: (self.bottomLine?.frame.origin.y)!, width: (self.bottomLine?.frame.width)!, height: (self.bottomLine?.frame.height)!)
            
            sender.isHighlighted = false
            sender.isSelected = true
            self.setSelectedIndex(index: sender.tag)
            self.delegate?.clickButton(button: sender)
        }
    }
    
    func titleColorForState(state: UIControlState) ->UIColor{
        if let color = colors[String(state.rawValue)]{
            return color
        }
        
        switch(state){
        case UIControlState.normal:
            return UIColor.darkGray
        case UIControlState.highlighted,UIControlState.selected:
            return self.tintColor
        case UIControlState.disabled:
            return UIColor.lightGray
        default:
            return self.tintColor
        }
    }
    
    func setTitleColorForState(color: UIColor, state: UIControlState){
        colors.updateValue(color, forKey: String(state.rawValue))
    }
    
    func selectMenuAction(index: Int) {
        let button = self.viewWithTag(index + 100) as! UIButton
        
        clickButtonAction(sender: button)
    }
    
    func setSelectedIndex(index: Int) {
        // update button color
        for i in 0...titleArray.count - 1 {
            let button = self.viewWithTag(100 + i) as! UIButton
            
            if button.tag == index {
                button.setTitleColor(styleColor, for: UIControlState.normal)
            } else {
                button.setTitleColor(UIColor.vtTextGrayColor(), for: UIControlState.normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuButtonView {
    private struct AssociatedKeys {
        static var kBottomLineKey = "BottomLineKey"
    }
    
    var bottomLine : UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kBottomLineKey) as? UIView
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.kBottomLineKey, newValue as UIView?,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

class ImageTitleButton: UIButton {
    enum ButtonType: Int {
        case Deafult
        case Share
    }
    
    var type: ButtonType = ButtonType.Deafult
    
    var onClickImageAction: ((ImageTitleButton) -> Void)?
    private var logoWidth: CGFloat?
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.clear
        image.isUserInteractionEnabled = false
        
        return image
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.vtTextGrayColor()
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        
        return label
    }()
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Init
    func instance(imageName: String, title: String, logoWidth: CGFloat  = 45, type: ButtonType = ButtonType.Deafult) -> ImageTitleButton {
        self.logoWidth = logoWidth
        self.type = type
        
        makeUI(imageName: imageName, title: title)
        setupViewConstraints()
        
        return self
    }
    
    func makeUI(imageName: String, title: String) {
        self.backgroundColor = UIColor.clear
        
        logoImageView.image = UIImage(named: imageName)
        bottomLabel.text = title
        
        addSubview(logoImageView)
        addSubview(bottomLabel)
        
        addTarget(self, action: #selector(ImageTitleButton.onClickButton), for: .touchUpInside)
    }
    
    func setupViewConstraints() {
        logoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(self.logoWidth!)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-10)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            switch type.rawValue {
            case ButtonType.Share.rawValue:
                make.top.equalTo(logoImageView.snp.bottom).offset(14)
            default:
                make.top.equalTo(logoImageView.snp.bottom).offset(5)
            }
            
            make.width.equalTo(self)
            make.height.equalTo(16)
            make.centerX.equalTo(self)
        }
    }
    
    // MARK: Actions
    @objc func onClickButton() {
        onClickImageAction?(self)
    }
}
