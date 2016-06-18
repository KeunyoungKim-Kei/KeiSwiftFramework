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

public let SECOND: NSTimeInterval   = 1
public let MINUTE: NSTimeInterval   = 60
public let HOUR: NSTimeInterval     = MINUTE * 60
public let DAY: NSTimeInterval      = HOUR * 24
public let WEEK: NSTimeInterval     = DAY * 7
public let YEAR: NSTimeInterval     = DAY * 365

public enum KDay: Int {
    case Day1 = 1, Day2, Day3, Day4, Day5, Day6, Day7, Day8, Day9
    case Day10, Day11, Day12, Day13, Day14, Day15, Day16, Day17, Day18, Day19
    case Day20, Day21, Day22, Day23, Day24, Day25, Day26, Day27, Day28, Day29
    case Day30, Day31
}

public enum KWeekday: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

public enum KMonth: Int {
    case January = 1
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case Novermber
    case December
}

public extension NSDate {
    /**
     The number of era units for **self**.
     */
    public var era: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era], fromDate: self)
        return components.era
    }
    
    
    
    /**
     The number of year units for **self**.
     */
    public var year: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year], fromDate: self)
        return components.year
    }
    
    
    
    /**
     The number of month units for **self**.
     */
    public var month: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Month], fromDate: self)
        return components.month
    }
    
    
    
    /**
     The number of day units for **self**.
     */
    public var day: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day], fromDate: self)
        return components.day
    }
    
    
    
    /**
     The number of hour units for **self**.
     */
    public var hour: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour], fromDate: self)
        return components.hour
    }
    
    
    
    /**
     The number of minute units for **self**.
     */
    public var minute: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Minute], fromDate: self)
        return components.minute
    }
    
    
    
    /**
     The number of second units for **self**.
     */
    public var second: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Second], fromDate: self)
        return components.second
    }
    
    
    /**
     The number of the weekday unit for **self**.
     */
    public var weekday: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday], fromDate: self)
        return components.weekday
    }
    
    
    
    /**
     The ordinal number of weekday units for **self**.
     */
    public var weekdayOrdinal: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.WeekdayOrdinal], fromDate: self)
        return components.weekdayOrdinal
    }
    
    
    
    /**
     The number of quarters for **self**.
     */
    public var quarter: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Quarter], fromDate: self)
        return components.quarter
    }
    
    
    
    /**
     The ISO 8601 week date of the year for **self**.
     */
    public var weekOfYear: Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.WeekOfYear], fromDate: self)
        return components.weekOfYear
    }
    
    
    
    public func removeTime() -> NSDate! {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)
        
        let result = NSDateComponents()
        result.timeZone = calendar.timeZone
        result.year = components.year
        result.month = components.month
        result.day = components.day
        result.hour = 0
        result.minute = 0
        result.second = 0
        
        return calendar.dateFromComponents(result)
    }
    
    
    
    public func startDateOfDay() -> NSDate {
        return self.removeTime()
    }
    
    
    
    public func endDateOfDay() -> NSDate {
        let start = startDateOfDay()
        let tomorrow = KInterval.dateByAddingDays(1, toDate: start)
        
        return KInterval.dateByAddingSeconds(-1, toDate: tomorrow)
    }
    
    
    
    public func startDateOfMonth() -> NSDate! {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month], fromDate: self)
        
        let result = NSDateComponents()
        result.timeZone = calendar.timeZone
        result.year = components.year
        result.month = components.month
        result.day = 1
        result.hour = 0
        result.minute = 0
        result.second = 0
        
        return calendar.dateFromComponents(result)
    }
    
    
    public func addMonths(months: Int = 1) -> NSDate! {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = months
        
        return calendar.dateByAddingComponents(components, toDate: self, options: [])
    }
    
    
    
    public func nextMonth() -> NSDate! {
        return addMonths()
    }
    
    
    
    public func lastMonth() -> NSDate! {
        return addMonths(-1)
    }
    
    
    
    public class func zeroDate() -> NSDate {
        return NSDate(timeIntervalSince1970: 0)
    }
}