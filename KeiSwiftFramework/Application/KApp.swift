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

open class KApp: UIResponder, UIApplicationDelegate {
    open var window: UIWindow?
    
    open class var runningOnSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    open var isFirstLaunchAfterInstall = false
    open var lastLaunchDate: NSDate {
        get {
            return KKeyValueStore.dateValue(K_LAST_LAUNCH_DATE, defaultValue: Today.now)
        }
        
        set {
            KKeyValueStore.saveDate(newValue, forKey: K_LAST_LAUNCH_DATE)
        }
    }
    
    open var secondsFromLastLaunch: TimeInterval = 0
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Life Cycle
    //
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
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
    open func registerForNotifications(forTypes types: UIUserNotificationType = [.alert, .badge, .sound], categories: Set<UIUserNotificationCategory>? = nil) {
        deviceTokenString = nil
        
        let settings = UIUserNotificationSettings(types: types, categories: categories)
        UIApplication.shared.registerUserNotificationSettings(settings)
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Remote Notification
    //
    open var deviceTokenString: String?
    open var pushNotificationRegistered: Bool {
        return deviceTokenString != nil
    }
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken token: Data) {
        let characterSet: CharacterSet = CharacterSet( charactersIn: "<>" )
        
        let tokenString: String = ( token.description as NSString )
            .trimmingCharacters( in: characterSet )
            .replacingOccurrences( of: " ", with: "" ) as String
        
        deviceTokenString = tokenString
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Commonly Used Directories
    //
    open static var documentsDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    open static var libraryDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    open static var applicationSupportDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    open static var cacheDirectoryURL: URL {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls.last!
    }
    
    
    
    open static var temporaryDirectoryURL: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Core Data stack
    var modelName: String!
    var useLightweightMigration = true
    var storeType = NSSQLiteStoreType
    
    
    
    open func setupCoreData(modelName name: String, storeType type: String = NSSQLiteStoreType, useLightweightMigration useMigration: Bool = true) {
        modelName = name
        useLightweightMigration = useMigration
        storeType = type
    }
    
    
    
    open lazy var managedObjectModel: NSManagedObjectModel = {
        assert(self.modelName != nil, "EMPTY CORE DATA MODEL NAME: use setupCoreData()")
        
        let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    
    
    open lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        assert(self.modelName != nil, "EMPTY CORE DATA MODEL NAME: use setupCoreData()")
        
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = KApp.documentsDirectoryURL.appendingPathComponent("\(self.modelName).sqlite")
        do {
            var options: [AnyHashable: Any]? = nil
            if self.useLightweightMigration {
                options = [NSMigratePersistentStoresAutomaticallyOption:NSNumber(value: true as Bool),
                           NSInferMappingModelAutomaticallyOption:NSNumber(value: true as Bool)]
            }
            
            try coordinator.addPersistentStore(ofType: self.storeType, configurationName: nil, at: url, options: options)
        } catch {
            abort()
        }
        
        return coordinator
    }()
    
    
    
    open lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}
