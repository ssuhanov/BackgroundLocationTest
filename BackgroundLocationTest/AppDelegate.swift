//
//  AppDelegate.swift
//  BackgroundLocationTest
//
//  Created by Serge Sukhanov on 2/24/18.
//  Copyright © 2018 Serge Sukhanov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let locationService = LocationService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Logger.showLog()
//        Logger.clearLog()
        Logger.log(message: "Application launched")
        UIDevice.current.isBatteryMonitoringEnabled = true
        locationService.requestPermission()
        locationService.start()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }
}
