//
//  NSDate+Compare.swift
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

public extension NSDate {
    public func hasSameYear(date: NSDate?) -> Bool {
        if let d = date {
            return d.year == self.year
        }
        
        return false
    }
    
    
    
    public func inThisYear() -> Bool {
        return hasSameYear(NSDate())
    }
    
    
    
    public func hasSameMonth(date: NSDate?, ignoreOtherComponents: Bool = false) -> Bool {
        if let d = date {
            if ignoreOtherComponents {
                return d.month == self.month
            }
            
            return hasSameYear(d) && d.month == self.month
        }
        
        return false
    }
    
    
    
    public func inThisMonth() -> Bool {
        return hasSameMonth(NSDate())
    }
    
    
    
    public func hasSameDay(date: NSDate?, ignoreOtherComponents: Bool = false) -> Bool {
        if let d = date {
            if ignoreOtherComponents {
                return d.day == self.day
            }
            
            return hasSameMonth(d) && d.day == self.day
        }
        
        return false
    }
    
    
    
    public func isToday() -> Bool {
        return hasSameDay(NSDate())
    }
    
    
    
    public func hasSameHour(date: NSDate?, ignoreOtherComponents: Bool = false) -> Bool {
        if let d = date {
            if ignoreOtherComponents {
                return d.hour == self.hour
            }
            
            return hasSameDay(d) && d.hour == self.hour
        }
        
        return false
    }
    
    
    
    public func hasSameMinute(date: NSDate?, ignoreOtherComponents: Bool = false) -> Bool {
        if let d = date {
            if ignoreOtherComponents {
                return d.minute == self.minute
            }
            
            return hasSameHour(d) && d.minute == self.minute
        }
        
        return false
    }
}