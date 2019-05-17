//
//  AppDelegate.swift
//  WaterControl
//
//  Created by Владимир on 10.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func applicationDidBecomeActive(_: UIApplication){
//        print("Я тута")
//        let mainDate = getDate()
//        let loadDate = loadData()
//        print(mainDate," СЕГОДНЯШНЯЯ ДАТА ")
//        print(loadDate!," ПОДГРУЖЕННАЯ ДАТА ")
//        
//        if(mainDate != loadDate!){
//            
//        }
    }
    

    func reloadViewFromNib() {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "settings") as! SettingsViewController
//        balanceViewController.present(balanceViewController, animated: true, completion: nil)
    }
    
//    func loadData() -> String?{
//        let mainNumber = UserDefaults.standard.string(forKey: "Date")
//        return mainNumber
//    }
//
//
//    func getDate() -> String{
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy"
//        let result = formatter.string(from: date)
//        return result
//    }

}


