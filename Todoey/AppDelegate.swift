//
//  AppDelegate.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print the path for our user default's file
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
        print("Did resign active")

        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
      
        print("Did enter background")

        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
        print("Did terminate")

        
    }


}

