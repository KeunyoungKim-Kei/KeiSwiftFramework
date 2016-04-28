//
//  Today.swift
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

public class Today: NSDate {
    public class var now: NSDate {
        return NSDate()
    }
    
    
    
    public class var startDate: NSDate {
        return NSDate().removeTime()
    }
    
    
    
    public class var endDate: NSDate {
        return NSDate().removeTime() + 24.hour - 1.second
    }
    
    
    
    public class func contains(date: NSDate) -> Bool {
        return startDate <= date && date <= endDate
    }
}



public class Yesterday: NSDate {
    public class var startDate: NSDate {
        return Today.startDate - 1.day
    }
    
    
    
    public class var endDate: NSDate {
        return Today.endDate - 1.day
    }
    
    
    
    public class func contains(date: NSDate) -> Bool {
        return startDate <= date && date <= endDate
    }
}




public class Tomorrow: NSDate {
    public class var startDate: NSDate {
        return Today.startDate + 1.day
    }
    
    
    
    public class var endDate: NSDate {
        return Today.endDate + 1.day
    }
    
    
    
    public class func contains(date: NSDate) -> Bool {
        return startDate <= date && date <= endDate
    }
}