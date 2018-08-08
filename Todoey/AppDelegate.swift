//
//  AppDelegate.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print the path for our user default's file
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
        
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    //'lazy' means only gets loaded with value when its needed
    
    lazy var persistentContainer: NSPersistentContainer = {
    //NSPersistentContainer is essentially a SQLite DB, by default
        
        let container = NSPersistentContainer(name: "DataModel")
        //HAS TO MATCH name of your DATA MODEL
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
        
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        //context is a temp area or scratchpad where you update and condition data until it sent off to be saved for more persistent storage
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
