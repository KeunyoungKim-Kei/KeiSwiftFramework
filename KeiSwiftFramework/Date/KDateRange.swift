//
//  KDateRange.swift
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



public func == (lhs: KDateRange, rhs: KDateRange) -> Bool {
    return (lhs.beginDate == rhs.beginDate) && (lhs.endDate == rhs.endDate)
}

public func != (lhs: KDateRange, rhs: KDateRange) -> Bool {
    return !(lhs == rhs)
}

open class KDateRange: NSObject {
    open var beginDate: NSDate
    open var endDate: NSDate
    
    public init(beginDate b: NSDate, endDate e: NSDate) {
        beginDate = b
        endDate = e
        
        super.init()
    }
    
    
    
    open func containsDate(_ date: NSDate?, ignoreTime: Bool = true) -> Bool {
        if ignoreTime {
            if let targetDate = date?.removeTime() {
                if (targetDate < beginDate.removeTime()) || (targetDate > endDate.removeTime()) {
                    return false
                }
                
                return true
            }
        } else {
            if let targetDate = date {
                if targetDate < beginDate || targetDate > endDate {
                    return false
                }
                
                return true
            }
        }
        
        
        return false
    }
}
