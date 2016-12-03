//
//  NSDate+Operators.swift
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


public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

public func !=(lhs: NSDate, rhs: NSDate) -> Bool {
    return !(lhs == rhs)
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}

public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
}

public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
}

public func -(lhs: NSDate, rhs: NSDate) -> TimeInterval {
    return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
}




/////////////////////////////////////////////////////////////////////
//
// MARK: -
//
public func +(lhs: NSDate, rhs: TimeInterval) -> NSDate {
    return lhs.addingTimeInterval(rhs)
}

public func +(lhs: TimeInterval, rhs: NSDate) -> NSDate {
    return rhs + lhs
}

public func -(lhs: NSDate, rhs: TimeInterval) -> NSDate {
    return lhs.addingTimeInterval(rhs * -1)
}

//public func -(lhs: NSTimeInterval, rhs: NSDate) -> NSDate {
//    return rhs - lhs
//}



/////////////////////////////////////////////////////////////////////
//
// MARK: - Month
//
public func ==(lhs: NSDate, rhs: KMonth) -> Bool {
    return lhs.month == rhs.rawValue
}

public func ==(lhs: KMonth, rhs: NSDate) -> Bool {
    return rhs == lhs
}

public func !=(lhs: NSDate, rhs: KMonth) -> Bool {
    return !(lhs == rhs)
}

public func !=(lhs: KMonth, rhs: NSDate) -> Bool {
    return !(lhs == rhs)
}




/////////////////////////////////////////////////////////////////////
//
// MARK: - Weekday
//
public func ==(lhs: NSDate, rhs: KWeekday) -> Bool {
    return lhs.weekday == rhs.rawValue
}

public func ==(lhs: KWeekday, rhs: NSDate) -> Bool {
    return rhs == lhs
}

public func !=(lhs: NSDate, rhs: KWeekday) -> Bool {
    return !(lhs == rhs)
}

public func !=(lhs: KWeekday, rhs: NSDate) -> Bool {
    return !(lhs == rhs)
}




/////////////////////////////////////////////////////////////////////
//
// MARK: - Day
//
public func ==(lhs: NSDate, rhs: KDay) -> Bool {
    return lhs.day == rhs.rawValue
}

public func ==(lhs: KDay, rhs: NSDate) -> Bool {
    return rhs == lhs
}

public func !=(lhs: NSDate, rhs: KDay) -> Bool {
    return !(lhs == rhs)
}

public func !=(lhs: KDay, rhs: NSDate) -> Bool {
    return !(lhs == rhs)
}
