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
    public var name: String {
        get {
            return getStringResourceValue(NSURLNameKey)
        }
    }
    
    
    
    public var exist: Bool {
        return checkResourceIsReachableAndReturnError(nil)
    }
    
    
    
    public var isDirectory: Bool {
        return getBoolResourceValue(NSURLIsDirectoryKey)
    }
    
    
    
    public var hidden: Bool {
        get {
            return getBoolResourceValue(NSURLIsHiddenKey)
        }
        
        set {
            do {
                try setResourceValue(newValue, forKey: NSURLIsHiddenKey)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    public var excludedFromBackup: Bool {
        get {
            return getBoolResourceValue(NSURLIsExcludedFromBackupKey)
        }
        
        set {
            do {
                try setResourceValue(newValue, forKey: NSURLIsExcludedFromBackupKey)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    public var fileSize: NSNumber {
        if !isDirectory {
            return getNSNumberResourceValue(NSURLFileSizeKey)
        }
        
        return 0.NSNumberValue
    }
    
    
    
    public var creationDate: NSDate {
        get {
            return getNSDateResourceValue(NSURLCreationDateKey)
        }
    }
    
    
    
    public var lastAccessDate: NSDate {
        get {
            return getNSDateResourceValue(NSURLContentAccessDateKey)
        }
    }
    
    
    
    public var modificationDate: NSDate {
        get {
            return getNSDateResourceValue(NSURLContentModificationDateKey)
        }
    }
    
    
    
    private func getStringResourceValue(key: String) -> String {
        var value: AnyObject? = ""
        do {
            try getResourceValue(&value, forKey: key)
        } catch { }
        
        if let str = value as? String {
            return str
        }
        
        return ""
    }
    
    
    
    private func getBoolResourceValue(key: String) -> Bool {
        var value: AnyObject? = false.NSNumberValue
        do {
            try getResourceValue(&value, forKey: key)
        } catch { }
        
        if let numberValue = value as? NSNumber {
            return numberValue.boolValue
        }
        
        return false
    }
    
    
    
    private func getNSNumberResourceValue(key: String) -> NSNumber {
        var value: AnyObject? = 0.NSNumberValue
        do {
            try getResourceValue(&value, forKey: key)
        } catch { }
        
        if let numberValue = value as? NSNumber {
            return numberValue
        }
        
        return 0.NSNumberValue
    }
    
    
    
    private func getNSDateResourceValue(key: String) -> NSDate {
        var value: AnyObject? = NSDate(timeIntervalSince1970: 0)
        do {
            try getResourceValue(&value, forKey: key)
        } catch { }
        
        if let date = value as? NSDate {
            return date
        }
        
        return NSDate(timeIntervalSince1970: 0)
    }
}