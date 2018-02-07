//
//  AppDelegate.swift
//  Vote
//
//  Created by 林以达 on 2017/11/14.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 改变导航默认信号栏字体颜色
        UINavigationBar.appearance().barStyle = .black
        // 没有导航条情况下设置状态栏
        UIApplication.shared.statusBarStyle  = .lightContent
        // 导航条颜色
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)
        // 导航前景色
        UINavigationBar.appearance().tintColor = UIColor.white
        // 导航字体颜色
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        UITabBar.appearance().tintColor = UIColor.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)//.white//分栏导航前景色
        UITabBar.appearance().barTintColor = UIColor(white: 1.0, alpha: 0.9)//.init(red: 75/255, green: 166/255, blue: 103/255, alpha: 1.0)//分栏导航条颜色
        
      //  [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//            [UIColor whiteColor], UITextAttributeTextColor,
//            nil] forState:UIControlStateNormal];
        
        // 启动图延长时间设置
        Thread.sleep(forTimeInterval: 1.5)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Vote")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate {
    // login
    func showLogin(){//登录页面
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginviewController") as! LoginTableViewController
        self.window?.rootViewController?.present(LoginViewController, animated: true, completion: nil)
    }
}

