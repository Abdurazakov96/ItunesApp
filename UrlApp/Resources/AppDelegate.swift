//
//  AppDelegate.swift
//  UrlApp
//
//  Created by Магомед Абдуразаков on 04/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLCache.shared = URLCache(memoryCapacity: 10000000, diskCapacity: 20000000, diskPath: NSTemporaryDirectory())
        return true
    }


}

