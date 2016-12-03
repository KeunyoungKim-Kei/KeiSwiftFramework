//
//  GCD.swift
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

open class GCD {
    open class var highPriority: DispatchQueue.GlobalQueuePriority {
        return DispatchQueue.GlobalQueuePriority.high
    }
    
    
    
    open class var defaultPriority: DispatchQueue.GlobalQueuePriority {
        return DispatchQueue.GlobalQueuePriority.default
    }
    
    
    
    open class var lowPriority: DispatchQueue.GlobalQueuePriority {
        return DispatchQueue.GlobalQueuePriority.low
    }
    
    
    
    open class var backgroundPriority: DispatchQueue.GlobalQueuePriority {
        return DispatchQueue.GlobalQueuePriority.background
    }
}



open class AsyncGCD: GCD {
    open class func performOnMainQueue(_ checkCurrentQueue: Bool = true, _ block: @escaping ()->()) {
        if checkCurrentQueue {
            if Thread.isMainThread {
                block()
                return
            }
        }
        
        performDelayedOnMainQueue(0.0, block)
    }
    
    
    
    open class func performDelayedOnMainQueue(_ delay: Double = 0.0, _ block: @escaping ()->()) {
        let queue = DispatchQueue.main
        
        if delay > 0.0 {
            let when = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            queue.asyncAfter(deadline: when, execute: block)
        } else {
            performOnQueue(queue, block)
        }
    }
    
    
    
    open class func performOnGlobalQueue(_ priority: DispatchQueue.GlobalQueuePriority = DispatchQueue.GlobalQueuePriority.default, _ block: @escaping ()->()) {
        performDelayedOnGlobalQueue(0.0, priority, block)
    }
    
    
    
    open class func performDelayedOnGlobalQueue(_ delay: Double = 0.0, _ priority: DispatchQueue.GlobalQueuePriority = DispatchQueue.GlobalQueuePriority.default, _ block: @escaping ()->()) {
        let queue = DispatchQueue.global(priority: priority)
        
        if delay > 0.0 {
            let when = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            queue.asyncAfter(deadline: when, execute: block)
        } else {
            performOnQueue(queue, block)
        }
    }
    
    
    
    open class func performOnQueue(_ queue: DispatchQueue, _ block: @escaping ()->()) {
        queue.async(execute: block)
    }
}
