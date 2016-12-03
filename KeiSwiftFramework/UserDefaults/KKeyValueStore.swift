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

open class KKeyValueStore {
    fileprivate class var store: UserDefaults {
        return UserDefaults.standard
    }
    
    
    
    open class func has(_ key: String) -> Bool {
        return store.object(forKey: key) != nil
    }
    
    
    
    open class func save(_ value: AnyObject, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func value(_ key: String, defaultValue: AnyObject? = nil) -> AnyObject? {
        guard let existValue = store.object(forKey: key) else {
            if let value = defaultValue {
                save(value, forKey: key)
            }
            
            return defaultValue
        }
        
        return existValue as AnyObject?
    }
    
    
    
    open class func remove(_ key: String, saveImmediately save: Bool = true) {
        store.removeObject(forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - String
    //
    open class func saveString(_ value: String, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func stringValue(_ key: String, defaultValue: String? = nil) -> String? {
        guard let existValue = store.object(forKey: key) as? String else {
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
    open class func numberValue(_ key: String, defaultValue: NSNumber? = nil) -> NSNumber? {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            if let value = defaultValue {
                store.set(value, forKey: key)
                store.synchronize()
            }
            
            return defaultValue
        }
        
        return existValue
    }
    
    
    
    open class func saveInteger(_ value: Int, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func integerValue(_ key: String, defaultValue: Int = 0) -> Int {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            saveInteger(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.intValue
    }
    
    
    
    open class func saveFloat(_ value: Float, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func floatValue(_ key: String, defaultValue: Float = 0.0) -> Float {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            saveFloat(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.floatValue
    }
    
    
    
    open class func saveDouble(_ value: Double, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func doubleValue(_ key: String, defaultValue: Double = 0.0) -> Double {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            saveDouble(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.doubleValue
    }
    
    
    
    open class func saveCGFloat(_ value: CGFloat, forKey key: String, saveImmediately save: Bool = true) {
        saveDouble(Double(value), forKey: key, saveImmediately: save)
    }
    
    
    
    open class func CGFloatValue(_ key: String, defaultValue: CGFloat = 0.0) -> CGFloat {
        return CGFloat(doubleValue(key, defaultValue: Double(defaultValue)))
    }
    
    
    
    open class func saveBool(_ value: Bool, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func saveTrue(_ key: String, saveImmediately save: Bool = true) {
        saveBool(true, forKey: key, saveImmediately: save)
    }
    
    
    
    open class func saveFalse(_ key: String, saveImmediately save: Bool = true) {
        saveBool(false, forKey: key, saveImmediately: save)
    }
    
    
    
    open class func boolValue(_ key: String, defaultValue: Bool = false) -> Bool {
        guard let existValue = store.object(forKey: key) as? NSNumber else {
            saveBool(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue.boolValue
    }
    
    
    
    open class func isTrue(_ key: String, defaultValue: Bool = false) -> Bool {
        return boolValue(key, defaultValue: defaultValue) == true
    }
    
    
    
    open class func isFalse(_ key: String, defaultValue: Bool = false) -> Bool {
        return boolValue(key, defaultValue: defaultValue) == false
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Date
    //
    open class func saveDate(_ value: NSDate, forKey key: String, saveImmediately save: Bool = true) {
        store.set(value, forKey: key)
        
        if save {
            store.synchronize()
        }
    }
    
    
    
    open class func saveNow(_ key: String, saveImmediately save: Bool = true) {
        saveDate(Today.now, forKey: key, saveImmediately: save)
    }
    
    
    
    open class func saveToday(_ key: String, saveImmediately save: Bool = true) {
        saveDate(Today.startDate, forKey: key, saveImmediately: save)
    }
    
    
    
    open class func dateValue(_ key: String, defaultValue: NSDate = NSDate(timeIntervalSince1970: 0)) -> NSDate {
        guard let existValue = store.object(forKey: key) as? Date else {
            saveDate(defaultValue, forKey: key)
            
            return defaultValue
        }
        
        return existValue as NSDate
    }
}
