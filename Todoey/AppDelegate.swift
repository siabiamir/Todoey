//
//  AppDelegate.swift
//  Todoey
//
//  Created by Amir Siabi on 12/29/17.
//  Copyright © 2017 Amir Siabi. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//      print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()

        } catch {
            print("Error initialising new realm, \(error)")
        }

        return true
    }


}

