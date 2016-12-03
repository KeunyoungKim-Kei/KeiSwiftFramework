//
//  NSDate+Components.swift
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

public let SECOND: TimeInterval   = 1
public let MINUTE: TimeInterval   = 60
public let HOUR: TimeInterval     = MINUTE * 60
public let DAY: TimeInterval      = HOUR * 24
public let WEEK: TimeInterval     = DAY * 7
public let YEAR: TimeInterval     = DAY * 365

public enum KDay: Int {
    case day1 = 1, day2, day3, day4, day5, day6, day7, day8, day9
    case day10, day11, day12, day13, day14, day15, day16, day17, day18, day19
    case day20, day21, day22, day23, day24, day25, day26, day27, day28, day29
    case day30, day31
}

public enum KWeekday: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

public enum KMonth: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case novermber
    case december
}

public extension NSDate {
    /**
     The number of era units for **self**.
     */
    public var era: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.era], from: self as Date)
        return components.era!
    }
    
    
    
    /**
     The number of year units for **self**.
     */
    public var year: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: self as Date)
        return components.year!
    }
    
    
    
    /**
     The number of month units for **self**.
     */
    public var month: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.month], from: self as Date)
        return components.month!
    }
    
    
    
    /**
     The number of day units for **self**.
     */
    public var day: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day], from: self as Date)
        return components.day!
    }
    
    
    
    /**
     The number of hour units for **self**.
     */
    public var hour: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: self as Date)
        return components.hour!
    }
    
    
    
    /**
     The number of minute units for **self**.
     */
    public var minute: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.minute], from: self as Date)
        return components.minute!
    }
    
    
    
    /**
     The number of second units for **self**.
     */
    public var second: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.second], from: self as Date)
        return components.second!
    }
    
    
    /**
     The number of the weekday unit for **self**.
     */
    public var weekday: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.weekday], from: self as Date)
        return components.weekday!
    }
    
    
    
    /**
     The ordinal number of weekday units for **self**.
     */
    public var weekdayOrdinal: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.weekdayOrdinal], from: self as Date)
        return components.weekdayOrdinal!
    }
    
    
    
    /**
     The number of quarters for **self**.
     */
    public var quarter: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.quarter], from: self as Date)
        return components.quarter!
    }
    
    
    
    /**
     The ISO 8601 week date of the year for **self**.
     */
    public var weekOfYear: Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.weekOfYear], from: self as Date)
        return components.weekOfYear!
    }
    
    
    
    public func removeTime() -> NSDate! {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self as Date)
        
        var result = DateComponents()
        (result as NSDateComponents).timeZone = calendar.timeZone
        result.year = components.year
        result.month = components.month
        result.day = components.day
        result.hour = 0
        result.minute = 0
        result.second = 0
        
        return calendar.date(from: result)! as NSDate
    }
    
    
    
    public func startDateOfDay() -> NSDate {
        return self.removeTime()
    }
    
    
    
    public func endDateOfDay() -> NSDate {
        let start = startDateOfDay()
        let tomorrow = KInterval.dateByAddingDays(1, toDate: start as NSDate)
        
        return KInterval.dateByAddingSeconds(-1, toDate: tomorrow as NSDate)
    }
    
    
    
    public func startDateOfMonth() -> NSDate! {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month], from: self as Date)
        
        var result = DateComponents()
        (result as NSDateComponents).timeZone = calendar.timeZone
        result.year = components.year
        result.month = components.month
        result.day = 1
        result.hour = 0
        result.minute = 0
        result.second = 0
        
        return calendar.date(from: result) as NSDate!
    }
    
    
    public func addMonths(_ months: Int = 1) -> Date! {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = months
                        
        return calendar.date(byAdding: components, to: self as Date)
    }
    
    
    
    public func nextMonth() -> Date! {
        return addMonths()
    }
    
    
    
    public func lastMonth() -> Date! {
        return addMonths(-1)
    }
    
    
    
    public static func zeroDate() -> Date {
        return Date(timeIntervalSince1970: 0)
    }
}
