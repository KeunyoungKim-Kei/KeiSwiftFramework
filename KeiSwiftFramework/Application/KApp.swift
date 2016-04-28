//
//  KApp.swift
//
//  Copyright (c) 2016 Keun young Kim <app@meetkei.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import CoreData

private let K_FIRST_LAUNCHING_AFTER_INSTALL = "K_FIRST_LAUNCHING_AFTER_INSTALL"
private let K_LAST_LAUNCH_DATE = "K_LAST_LAUNCH_DATE"

public class KApp: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    
    public class var runningOnSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    public var isFirstLaunchAfterInstall = false
    public var lastLaunchDate: NSDate {
        get {
            return KKeyValueStore.dateValue(K_LAST_LAUNCH_DATE, defaultValue: Today.now)
        }
        
        set {
            KKeyValueStore.saveDate(newValue, forKey: K_LAST_LAUNCH_DATE)
        }
    }
    
    public var secondsFromLastLaunch: NSTimeInterval = 0
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Life Cycle
    //
    public func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        isFirstLaunchAfterInstall = KKeyValueStore.boolValue(K_FIRST_LAUNCHING_AFTER_INSTALL, defaultValue: true)
        
        if isFirstLaunchAfterInstall {
            KKeyValueStore.saveFalse(K_FIRST_LAUNCHING_AFTER_INSTALL)
            print("K_FIRST_LAUNCHING_AFTER_INSTALL")
            secondsFromLastLaunch = 0
        } else {
            print("REGULAR LAUNCH")
            secondsFromLastLaunch = Today.now - lastLaunchDate
        }
        
        
        lastLaunchDate = Today.now
        return true
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Notification
    //
    public func registerForNotifications(forTypes types: UIUserNotificationType = [.Alert, .Badge, .Sound], categories: Set<UIUserNotificationCategory>? = nil) {
        deviceTokenString = nil
        
        let settings = UIUserNotificationSettings(forTypes: types, categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Remote Notification
    //
    public var deviceTokenString: String?
    public var pushNotificationRegistered: Bool {
        return deviceTokenString != nil
    }
    
    public func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken token: NSData) {
        let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        let tokenString: String = ( token.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        deviceTokenString = tokenString
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Core Data stack
    var modelName: String!
    var useLightweightMigration = true
    var storeType = NSSQLiteStoreType
    
    
    
    public func setupCoreData(modelName name: String, storeType type: String = NSSQLiteStoreType, useLightweightMigration useMigration: Bool = true) {
        modelName = name
        useLightweightMigration = useMigration
        storeType = type
    }
    
    
    
    public lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    
    
    public lazy var managedObjectModel: NSManagedObjectModel = {
        assert(self.modelName != nil, "EMPTY CORE DATA MODEL NAME: use setupCoreData()")
        
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    
    
    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        assert(self.modelName != nil, "EMPTY CORE DATA MODEL NAME: use setupCoreData()")
        
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(self.modelName).sqlite")
        do {
            var options: [NSObject: AnyObject]? = nil
            if self.useLightweightMigration {
                options = [NSMigratePersistentStoresAutomaticallyOption:NSNumber(bool: true),
                           NSInferMappingModelAutomaticallyOption:NSNumber(bool: true)]
            }
            
            try coordinator.addPersistentStoreWithType(self.storeType, configuration: nil, URL: url, options: options)
        } catch {
            abort()
        }
        
        return coordinator
    }()
    
    
    
    public lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}