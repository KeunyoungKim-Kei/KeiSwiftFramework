//
//  NSURL+Property.swift
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

public extension NSURL {
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Accessing the Properties of the URL
    
    /**
     The resource’s name in the file system, returned as an String. (read-only)
     */
    public var name: String {
        return getStringResourceValue(URLResourceKey.nameKey.rawValue)
    }
    
    
    
    /**
     A Boolean value that determines whether the resource pointed to by a file URL can be reached. (read-only)
     */
    public var exist: Bool {
        return checkResourceIsReachableAndReturnError(nil)
    }
    
    
    
    /**
     A Boolean value that determines whether the resource is a directory. (read-only)
     */
    public var isDirectory: Bool {
        return getBoolResourceValue(URLResourceKey.isDirectoryKey.rawValue)
    }
    
    
    
    /**
     A Boolean value that determines whether the resource is hidden. (read-write)
     */
    public var hidden: Bool {
        get {
            return getBoolResourceValue(URLResourceKey.isHiddenKey.rawValue)
        }
        
        set {
            do {
                try setResourceValue(newValue as AnyObject?, forKey: URLResourceKey.isHiddenKey)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    /**
     A Boolean value that determines whether the resource is excluded from all backups of app data. (read-write)
     */
    public var excludedFromBackup: Bool {
        get {
            return getBoolResourceValue(URLResourceKey.isExcludedFromBackupKey.rawValue)
        }
        
        set {
            do {
                try setResourceValue(newValue as AnyObject?, forKey: URLResourceKey.isExcludedFromBackupKey)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    /**
     A NSNumber object that represents the resource’s size in bytes. (read-only)
     */
    public var fileSize: NSNumber {
        if !isDirectory {
            return getNSNumberResourceValue(URLResourceKey.fileSizeKey.rawValue)
        }
        
        return 0.NSNumberValue
    }
    
    
    
    /**
     A NSDate object that represents the resource’s creation date. (read-only)
     */
    public var creationDate: Date {
        get {
            return getNSDateResourceValue(URLResourceKey.creationDateKey.rawValue)
        }
    }
    
    
    
    /**
     A NSDate object that represents the time at which the resource was most recently accessed. (read-only)
     */
    public var lastAccessDate: Date {
        get {
            return getNSDateResourceValue(URLResourceKey.contentAccessDateKey.rawValue)
        }
    }
    
    
    
    /**
     A NSDate object that represents the time at which the resource was most recently modified. (read-only)
     */
    public var modificationDate: Date {
        get {
            return getNSDateResourceValue(URLResourceKey.contentModificationDateKey.rawValue)
        }
    }
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: - Getting and Setting File System Resource Properties
    
    /**
     Returns the string value of the resource property for the specified key.
     
     - Parameter key: The name of one of the URL’s resource properties.
     
     - Returns: Valid string if value is successfully populated; otherwise, empty stirng("").
     */
    fileprivate func getStringResourceValue(_ key: String) -> String {
        var value: AnyObject? = "" as AnyObject?
        do {
            try getResourceValue(&value, forKey: URLResourceKey(rawValue: key))
        } catch { }
        
        if let str = value as? String {
            return str
        }
        
        return ""
    }
    
    
    
    /**
     Returns the boolean value of the resource property for the specified key.
     
     - Parameter key: The name of one of the URL’s resource properties.
     
     - Returns: true if value is successfully populated; otherwise, false.
     */
    fileprivate func getBoolResourceValue(_ key: String) -> Bool {
        var value: AnyObject? = false.NSNumberValue
        do {
            try getResourceValue(&value, forKey: URLResourceKey(rawValue: key))
        } catch { }
        
        if let numberValue = value as? NSNumber {
            return numberValue.boolValue
        }
        
        return false
    }
    
    
    
    /**
     Returns the NSNumber object of the resource property for the specified key.
     
     - Parameter key: The name of one of the URL’s resource properties.
     
     - Returns: Valid NSNumber object if value is successfully populated; otherwise, NSNumber object containing 0.
     */
    fileprivate func getNSNumberResourceValue(_ key: String) -> NSNumber {
        var value: AnyObject? = 0.NSNumberValue
        do {
            try getResourceValue(&value, forKey: URLResourceKey(rawValue: key))
        } catch { }
        
        if let numberValue = value as? NSNumber {
            return numberValue
        }
        
        return 0.NSNumberValue
    }
    
    
    
    /**
     Returns the NSDate object of the resource property for the specified key.
     
     - Parameter key: The name of one of the URL’s resource properties.
     
     - Returns: Valid NSDate object if value is successfully populated; otherwise, NSDate object set to 00:00:00 UTC on 1 January 1970.
     */
    fileprivate func getNSDateResourceValue(_ key: String) -> Date {
        var value: AnyObject? = Date(timeIntervalSince1970: 0) as AnyObject?
        do {
            try getResourceValue(&value, forKey: URLResourceKey(rawValue: key))
        } catch { }
        
        if let date = value as? Date {
            return date
        }
        
        return Date(timeIntervalSince1970: 0)
    }
}
