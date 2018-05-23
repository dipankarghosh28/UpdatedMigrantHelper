//
//  AppDelegate.swift
//  NeedHelp
//
//  Created by Dipankar Ghosh on 5/21/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // FirebaseApp.configure()
        return true
    }
    override init() {
        FirebaseApp.configure()
       let db1 = Firestore.firestore()
        // [END default_firestore]
    print(db1) // silence warning
    //    Database.database().isPersistenceEnabled = true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
   
    
}

