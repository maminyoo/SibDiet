//
//  AppDelegate.swift
//  Sibdiet
//
//  Created by amin sadeghian on 9/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import UserNotifications

protocol OutSidePeymentDelegate: AnyObject{
    func payed()
    func cancelPayment()
    func didBecome()
}

protocol ApplicationDelegate: AnyObject {
    func didBecomeActive()
    func didEnterBackground()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, OutSidePeymentDelegate, ApplicationDelegate{
  
    weak var delegatePayed: OutSidePeymentDelegate?
    weak var delegateApp: ApplicationDelegate?

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken:Data) {
        let deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        settings.deviceToken = deviceToken
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let params = components.queryItems else {
                cancelPayment()
                return false
        }
        if let _ = params.first(where: { $0.name == "status" })?.value {
            payed()
            return true
        } else { return false }
    }
    
    func payed() {
        delegatePayed?.payed()
    }
    
    func cancelPayment(){
        delegatePayed?.cancelPayment()
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        profile.deviceId = UIDevice.current.identifierForVendor!.uuidString
        repoConnection.registerDevice()
        accessNotification()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        didEnterBackground()
    }
    
    func didEnterBackground() {
        delegateApp?.didEnterBackground()
    }
    
    func accessNotification(){
        UNUserNotificationCenter.current().delegate = self
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            settings.enableNotification = granted
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "test"{
            print("handel")
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
        
        UNUserNotificationCenter.current().getNotificationSettings() { (setttings) in
            switch setttings.soundSetting {
            case .enabled:  print("enabled")
            case .disabled: print("setting")
            case .notSupported: print("something")
            @unknown default: self.fatalError() }
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func fatalError(){}
    
    func applicationWillResignActive(_ application: UIApplication) {
        didEnterBackground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        didBecome()
        didBecomeActive()
        if UIApplication.shared.applicationIconBadgeNumber != 0{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
    
    func didBecome(){
        delegatePayed?.didBecome()
    }
    
    func didBecomeActive(){
        delegateApp?.didBecomeActive()
    }
}

