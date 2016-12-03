//
//  KViewController+Notification.swift
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

public extension KViewController {
    public func handleNotification(_ noti: Notification) {
        //print("HANDLE NOTIFICATION")
    }
    
    
    
    public func postNotification(_ name: String, object: AnyObject? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
    }
    
    
    
    public func registerNotification(_ name: String) {
        NotificationCenter.default.addObserver(self, selector: #selector(KViewController.handleNotification(_:)), name: NSNotification.Name(rawValue: name), object: nil)
        notificationNames.append(name)
    }
    
    
    
    public func registerNotifications(_ names: [String]) {
        for name in names {
            registerNotification(name)
        }
    }
    
    
    
    public func deregisterNotification(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
        
        if let index = notificationNames.index(of: name) {
            notificationNames.remove(at: index)
        }
    }
    
    
    
    public func deregisterNotifications(_ names: [String]) {
        for name in names {
            deregisterNotification(name)
        }
    }
    
    
    
    public func deregisterAllNotification() {
        notificationNames.removeAll()
        NotificationCenter.default.removeObserver(self)
    }
}
