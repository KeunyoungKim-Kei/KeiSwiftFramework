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
    
    
    
    /**
     Returns whether **self** is sunday.
     
     - Returns: *true* if the date is sunday, otherwise *false*.
     
     - Author: Keun young Kim
     */
    public func isSunday() -> Bool {
        return self == KWeekday.Sunday
    }
    
    
    
    /**
     Returns whether **self** is today.
     
     - Returns: *true* if **self** is today, otherwise *false*.
     
     - Author: Keun young Kim
     */
    public func isToday() -> Bool {
        if #available(iOS 8, *) {
            let calendar = NSCalendar.currentCalendar()
            return calendar.isDateInToday(self)
        }
        
        return hasSameDay(NSDate())
    }
    
    
    
    /**
     Returns whether **self** is yesterday.
     
     - Returns: *true* if **self** is yesterday, otherwise *false*.
     
     - Author: Keun young Kim
     */
    @available(iOS 8, *)
    public func isYesterday() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDateInYesterday(self)
    }
    
    
    
    /**
     Returns whether **self** is tomorrow.
     
     - Returns: *true* if **self** is tomorrow, otherwise *false*.
     
     - Author: Keun young Kim
     */
    @available(iOS 8, *)
    public func isTomorrow() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDateInTomorrow(self)
    }
    
    
    
    /**
     Returns whether two dates are in the same day.
     
     - Parameter date: date to compare
     
     - Returns: *true* if both dates are within the same day, otherwise *no*.
     
     - Author: Keun young Kim
     */
    @available(iOS 8, *)
    public func isSameDay(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDate(date, inSameDayAsDate: self)
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