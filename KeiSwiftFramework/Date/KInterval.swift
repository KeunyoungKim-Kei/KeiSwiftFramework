//
//  KInterval.swift
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

infix operator ~ : MultiplicationPrecedence
public func ~(lhs: NSDate, rhs: NSDate) -> TimeInterval {
    return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
}

open class KInterval: NSObject {
    open class func exceeded(_ interval: TimeInterval, minDate: NSDate, maxDate: NSDate = Today.now) -> Bool {
        return maxDate - minDate > interval
    }
    
    
    
    open class func dateByAdding(toDate date: NSDate, year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) -> NSDate {
        let calendar = NSCalendar.current
        
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = day
        comps.hour = hour
        comps.minute = minute
        comps.second = second
        
        return calendar.date(byAdding: comps, to: date as Date)! as NSDate
    }
    
    
    
    open class func years(minDate: NSDate, maxDate: NSDate) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: minDate as Date, to: maxDate as Date)
        return components.year!
    }
    
    
    
    open class func dateByAddingYears(_ year: Int, toDate: NSDate) -> NSDate {
        return dateByAdding(toDate: toDate, year: year)        
    }
    
    
    
    open class func months(minDate: Date, maxDate: Date) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.month], from: minDate as Date, to: maxDate as Date)
        return components.month!
    }
    
    
    
    open class func dateByAddingMonths(_ month: Int, toDate: NSDate) -> NSDate {
        return dateByAdding(toDate: toDate, month: month)
    }
    
    
    
    open class func days(minDate: NSDate, maxDate: NSDate) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: minDate as Date, to: maxDate as Date)
        return components.day!
    }
    
    
    
    open class func days(range: KDateRange) -> Int {
        return days(minDate: range.beginDate, maxDate: range.endDate)
    }
    
    
    
    open class func dateByAddingDays(_ day: Int, toDate: NSDate) -> NSDate {
        return dateByAdding(toDate: toDate, day: day)
    }
    
    
    
    open class func hours(minDate: NSDate, maxDate: NSDate) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: minDate as Date, to: maxDate as Date)
        return components.hour!
    }
    
    
    
    open class func minutes(minDate: NSDate, maxDate: NSDate, minValue: Int = 0) -> Int {
        assert(minDate <= maxDate, "minDate > maxDate")
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.minute], from: minDate as Date, to: maxDate as Date)
        
        return max(components.minute!, minValue)
    }
    
    
    
    open class func minutesBeforeNow(_ date: NSDate, minValue: Int = 0) -> Int {
        return minutes(minDate: date, maxDate: NSDate(), minValue: minValue)
    }
    
    
    
    open class func minutesAfterNow(_ date: NSDate, minValue: Int = 0) -> Int {
        return minutes(minDate: NSDate(), maxDate: date, minValue: minValue)
    }
    
    
    
    open class func dateByAddingSeconds(_ second: Int, toDate: NSDate) -> NSDate {
        return dateByAdding(toDate: toDate, second: second)
    }
}
