//
//  KTimeProfiler.swift
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

open class KTimeProfiler {
    static let sharedInstance = KTimeProfiler()
    
    var checkPoints = [(tag: String, time: TimeInterval)]()
    
    
    
    open class func start() {
        sharedInstance.checkPoints.removeAll()
        sharedInstance.checkPoints.append(("Start", Today.now.timeIntervalSince1970))
    }
    
    
    
    open class func checkpoint(_ tag: String? = nil) {
        let checkPointTag = tag ?? "Checkpoint \(sharedInstance.checkPoints.count)"
        sharedInstance.checkPoints.append((checkPointTag, Today.now.timeIntervalSince1970))
    }
    
    
    
    open class func report(verbose: Bool = false, funcationName: String = #function) {
        if sharedInstance.checkPoints.count < 1 {
            print("KTimeProfiler: Nothing to report. Start new session!")
            return
        }
        
        sharedInstance.checkPoints.append(("End", Today.now.timeIntervalSince1970))
        
        let start = sharedInstance.checkPoints.first!.time
        let end = sharedInstance.checkPoints.last!.time
        
        let total = String(format: "%.6f", end - start)
        print("KTimeProfiler: \(funcationName) in \(total)s")
        
        if verbose {
            var maxLength = 15
            for item in sharedInstance.checkPoints {
                maxLength = max(item.tag.characters.count, maxLength)
            }
            
            print("==================================================")
            for index in 0..<sharedInstance.checkPoints.count {
                let item = sharedInstance.checkPoints[index]
                
                var tag = item.tag
                if tag.characters.count < maxLength {
                    tag = item.tag.padding(toLength: maxLength, withPad: " ", startingAt: 0)
                }
                
                if item == sharedInstance.checkPoints.first! {
                    print("\(tag)  0")
                } else {
                    let prev = sharedInstance.checkPoints[index - 1]
                    
                    let time = String(format: "%.6f", item.time - prev.time)
                    print("\(tag) +\(time)")
                }
            }
            print("==================================================")
            print("\("total".padding(toLength: maxLength, withPad: " ", startingAt: 0))  \(total)")
            print("==================================================")
        }
        
        sharedInstance.checkPoints.removeAll()
    }
}
