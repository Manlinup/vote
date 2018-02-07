//
//  VTAlert.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/6.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit

class VTAlert {
    class func alert(title: String, message: String?, dismissTitle: String, inViewController viewController: UIViewController?, withDismissAction dismissAction: (() -> Void)?) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action -> Void in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func alert(title: String, message: String?, dismissTitle: String, confirmTitle: String, inViewController viewController: UIViewController?, withDismissAction dismissAction: (() -> Void)?, withConfirmAction confirmAction: (() -> Void)?) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let _dismissAction: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action -> Void in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            
            let _confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action -> Void in
                if let confirmAction = confirmAction {
                    confirmAction()
                }
            }
            
            alertController.addAction(_dismissAction)
            alertController.addAction(_confirmAction)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func alertSorry(title: String? = "出错了", message: String?, inViewController viewController: UIViewController?, withDismissAction dismissAction: @escaping () -> Void) {
        alert(title: title!, message: message, dismissTitle: "确定", inViewController: viewController, withDismissAction: dismissAction)
    }
    
    class func alertSorry(title: String? = "出错了", message: String?, inViewController viewController: UIViewController?) {
        alert(title: title!, message: message, dismissTitle: "确定", inViewController: viewController, withDismissAction: nil)
    }
    
    class func alertSorryTips(title: String? = "", message: String?, inViewController viewController: UIViewController?) {
        alert(title: title!, message: message, dismissTitle: "确定", inViewController: viewController, withDismissAction: nil)
    }
    
    class func textInput(title: String, placeholder: String?, oldText: String?, dismissTitle: String, inViewController viewController: UIViewController?, withFinishedAction finishedAction: ((_ text: String) -> Void)?) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            
            alertController.addTextField { (textField) -> Void in
                textField.placeholder = placeholder
                textField.text = oldText
            }
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action -> Void in
                if let finishedAction = finishedAction {
                    if let textField = alertController.textFields?.first, let text = textField.text {
                        finishedAction(text)
                    }
                }
            }
            alertController.addAction(action)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func textInput(title: String, message: String?, placeholder: String?, oldText: String?, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, withConfirmAction confirmAction: ((_ text: String) -> Void)?, cancelAction: (() -> Void)?) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alertController.addTextField { (textField) -> Void in
                textField.placeholder = placeholder
                textField.text = oldText
            }
            
            let _cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { action -> Void in
                cancelAction?()
            }
            
            alertController.addAction(_cancelAction)
            
            let _confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action -> Void in
                if let textField = alertController.textFields?.first, let text = textField.text {
                    confirmAction?(text)
                }
            }
            
            alertController.addAction(_confirmAction)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func confirmOrCancel(title: String, message: String, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, withConfirmAction confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { action -> Void in
                cancelAction()
            }
            alertController.addAction(cancelAction)
            
            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action -> Void in
                confirmAction()
            }
            
            alertController.addAction(confirmAction)
            
            alertController.view.tintColor = UIColor.black
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
}

