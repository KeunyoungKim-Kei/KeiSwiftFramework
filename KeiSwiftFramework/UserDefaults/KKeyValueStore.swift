//
//  KKeyValueStore.swift
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

public class KKeyValueStore {
    private class var store: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    
    
    public class func has(key: String) -> Bool {
        return store.objectForKey(key) != nil
    }
    
    
    
    public class func save(value: AnyObject, forKey key: String, saveImmediately save: Bool = true) {
        store.setObject(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func value(key: String, defaultValue: AnyObject? = nil) -> AnyObject? {
        guard let existValue = store.objectForKey(key) else {
            if let value = defaultValue {
                save(value, forKey: key)
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    public class func remove(key: String, saveImmediately save: Bool = true) {
        store.removeObjectForKey(key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - String
    //
    public class func saveString(value: String, forKey key: String, saveImmediately save: Bool = true) {
        store.setObject(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func stringValue(key: String, defaultValue: String? = nil) -> String? {
        guard let existValue = store.objectForKey(key) as? String else {
            if let value = defaultValue {
                saveString(value, forKey: key)
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Number
    //
    public class func numberValue(key: String, defaultValue: NSNumber? = nil) -> NSNumber? {
        guard let existValue = store.objectForKey(key) as? NSNumber else {
            if let value = defaultValue {
                store.setObject(value, forKey: key)
                store.synchronize()
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    public class func saveInteger(value: Int, forKey key: String, saveImmediately save: Bool = true) {
        store.setInteger(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func integerValue(key: String, defaultValue: Int = 0) -> Int {
        guard let existValue = store.objectForKey(key) as? NSNumber else {
            saveInteger(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.integerValue
    }
    
    
    
    public class func saveFloat(value: Float, forKey key: String, saveImmediately save: Bool = true) {
        store.setFloat(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func floatValue(key: String, defaultValue: Float = 0.0) -> Float {
        guard let existValue = store.objectForKey(key) as? NSNumber else {
            saveFloat(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.floatValue
    }
    
    
    
    public class func saveDouble(value: Double, forKey key: String, saveImmediately save: Bool = true) {
        store.setDouble(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func doubleValue(key: String, defaultValue: Double = 0.0) -> Double {
        guard let existValue = store.objectForKey(key) as? NSNumber else {
            saveDouble(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.doubleValue
    }
    
    
    
    public class func saveCGFloat(value: CGFloat, forKey key: String, saveImmediately save: Bool = true) {
        saveDouble(Double(value), forKey: key, saveImmediately: save)
    }
    
    
    
    public class func CGFloatValue(key: String, defaultValue: CGFloat = 0.0) -> CGFloat {
        return CGFloat(doubleValue(key, defaultValue: Double(defaultValue)))
    }
    
    
    
    public class func saveBool(value: Bool, forKey key: String, saveImmediately save: Bool = true) {
        store.setBool(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func saveTrue(key: String, saveImmediately save: Bool = true) {
        saveBool(true, forKey: key, saveImmediately: save)
    }
    
    
    
    public class func saveFalse(key: String, saveImmediately save: Bool = true) {
        saveBool(false, forKey: key, saveImmediately: save)
    }
    
    
    
    public class func boolValue(key: String, defaultValue: Bool = false) -> Bool {
        guard let existValue = store.objectForKey(key) as? NSNumber else {
            saveBool(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.boolValue
    }
    
    
    
    public class func isTrue(key: String, defaultValue: Bool = false) -> Bool {
        return boolValue(key, defaultValue: defaultValue) == true
    }
    
    
    
    public class func isFalse(key: String, defaultValue: Bool = false) -> Bool {
        return boolValue(key, defaultValue: defaultValue) == false
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Date
    //
    public class func saveDate(value: NSDate, forKey key: String, saveImmediately save: Bool = true) {
        store.setObject(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    public class func saveNow(key: String, saveImmediately save: Bool = true) {
        saveDate(Today.now, forKey: key, saveImmediately: save)
    }
    
    
    
    public class func saveToday(key: String, saveImmediately save: Bool = true) {
        saveDate(Today.startDate, forKey: key, saveImmediately: save)
    }
    
    
    
    public class func dateValue(key: String, defaultValue: NSDate = NSDate(timeIntervalSince1970: 0)) -> NSDate {
        guard let existValue = store.objectForKey(key) as? NSDate else {
            saveDate(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue
    }
}
