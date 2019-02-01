//
//  AppDelegate.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 31/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    var firstLaunch: Bool!

    // MARK: - Life Cycle Methods
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        checkIfFirstLaunch()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    // MARK: - Helper Methods
    
    func checkIfFirstLaunch() {
        if UserDefaults.standard.object(forKey: UserDefaultsKeys.firstLaunch) == nil {
            self.firstLaunch = true
            UserDefaults.standard.set(false, forKey: UserDefaultsKeys.firstLaunch)
            UserDefaults.standard.synchronize()
        } else {
            self.firstLaunch = false
        }
    }

    func saveContext () {
        let context = DataController.shared.viewContext
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

