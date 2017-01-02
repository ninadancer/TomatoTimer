//
//  AppDelegate.swift
//  TomatoTimer
//
//  Created by 蓉蓉 邓 on 24/12/2016.
//  Copyright © 2016 Fancy boy. All rights reserved.
//

import UIKit
import WatchConnectivity
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var focusViewController: FocusViewController?
    let kRegisterNotificationSettings = "kRegisterNotificationSettings"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        customizeAppearance()
        registerDefaultUserDefaults()
        
        focusViewController = FocusViewController(nibName: nil, bundle: nil)
        
        window?.rootViewController = focusViewController
        window?.makeKeyAndVisible()
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            handleShortcut(shortcutItem.type)
        }
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        
        if identifier == "BREAK_ACTION" {
            focusViewController?.startBreak(sender: nil)
        } else if identifier == "WORK_ACTION" {
            focusViewController?.startWork(sender: nil)
        }
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCut = handleShortcut(shortcutItem.type)
        completionHandler(handledShortCut)
    }
    
    
    func handleShortcut(_ shortCut: String) -> Bool {
        guard let last = shortCut.components(separatedBy: ".").last else {
            return false
        }
        
        switch last {
        case "Work":
            self.focusViewController?.startTimerWithType(timerType: .Work)
        case "Break":
            self.focusViewController?.startTimerWithType(timerType: .Break)
        default:
            return false
        }
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification being triggered")
        completionHandler(.alert)
    }
    
    func customizeAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.yellow
        UINavigationBar.appearance().barTintColor = TimerStyleKit.backgroundColor
        
        let titleAttributes = [NSForegroundColorAttributeName: TimerStyleKit.timerColor]
        UINavigationBar.appearance().titleTextAttributes = titleAttributes
    }
    
    func registerDefaultUserDefaults() {
        let defaultPreferences: [String: Any] = [kRegisterNotificationSettings : true, TimerType.Work.rawValue : 1501, TimerType.Break.rawValue : 301, TimerType.Procrastination.rawValue: 601]
        UserDefaults.standard.register(defaults: defaultPreferences)
        UserDefaults.standard.synchronize()
        
        if UserDefaults.standard.bool(forKey: kRegisterNotificationSettings) {
            let restAction = UNNotificationAction(identifier: "BREAK_ACTION", title: "Start Break", options: .destructive)
            let workAction = UNNotificationAction(identifier: "WORK_ACTION", title: "Start Work", options: .foreground)
            let actions = [restAction, workAction]
            
            let category = UNNotificationCategory(identifier: "START_CATEGORY", actions: actions, intentIdentifiers: [], options: [])
            let center = UNUserNotificationCenter.current()
            center.setNotificationCategories([category])
            center.requestAuthorization(options: [.alert, .badge], completionHandler: { (granted, error) in
                if granted {
                    print("Registration successfully")
                    center.getNotificationSettings(completionHandler: { (_) in
                        print("22222222222")
                    })
                } else {
                    print("Registration failed")
                }
            })
            
            UIApplication.shared.registerForRemoteNotifications()
            
            UserDefaults.standard.set(false, forKey: kRegisterNotificationSettings)
            UserDefaults.standard.synchronize()
        }
    }
}
