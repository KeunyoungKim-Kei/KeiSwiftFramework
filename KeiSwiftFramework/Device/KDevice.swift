//
//  KDevice.swift
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

import UIKit
import CoreTelephony

open class KDevice {
    open class var mainScreenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    
    
    open class var mainScreenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    
    open class var mainScreenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    
    
    class func canPhoneCall() -> Bool {
        var canCall = false
        let url = URL(string: "tel://")
        if UIApplication.shared.canOpenURL(url!) {
            let info = CTTelephonyNetworkInfo()
            guard let carrier = info.subscriberCellularProvider else {
                return canCall
            }
            
            let mnc = carrier.mobileNetworkCode
            
            if String.isValid(mnc) {
                canCall = true
            }
        }
        
        return canCall
    }
}
