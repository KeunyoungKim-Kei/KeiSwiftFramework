//
//  Double+TimeInterval.swift
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

public extension Double {
    public var second: NSTimeInterval {
        return self * SECOND
    }
    
    public var minute: NSTimeInterval {
        return self * MINUTE
    }
    
    public var hour: NSTimeInterval {
        return self * HOUR
    }
    
    public var day: NSTimeInterval {
        return self * DAY
    }
    
    public var year: NSTimeInterval {
        return self * YEAR
    }
    
    public var secondInterval: NSTimeInterval {
        return self * SECOND
    }
    
    public var minuteInterval: NSTimeInterval {
        if self > 0 {
            return self / MINUTE
        }
        
        return self
    }
    
    public var hourInterval: NSTimeInterval {
        if self > 0 {
            return self / HOUR
        }
        
        return self
    }
    
    public var dayInterval: NSTimeInterval {
        if self > 0 {
            return self / DAY
        }
        
        return self
    }
    
    public func toString(format: String, convertToInt: Bool = true) -> String {
        if convertToInt {
            return String(format: format, Int(self))
        }
        
        return String(format: format, self)
    }
}

