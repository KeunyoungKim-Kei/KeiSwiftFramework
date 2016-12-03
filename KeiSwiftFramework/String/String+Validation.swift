//
//  String+Validation.swift
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

public extension String {
    public static func isValid(_ str: String?) -> Bool {
        guard let s = str else {
            return false
        }
        
        let trimmedString = s.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
        
        
        return trimmedString.characters.count > 0
    }
    
    
    
    public static func isNullOrEmpty(_ str: String?) -> Bool {
        return !isValid(str)
    }
    
    
    
    public static func lengthCheck(_ str: String?, minimumLength: Int, maximumLength: Int = Int.max) -> Bool {
        if String.isNullOrEmpty(str) {
            return false
        }
        
        return str!.characters.count >= minimumLength && str!.characters.count <= maximumLength
    }
    
    
    
    public func equalsTo(_ str: String?) -> Bool {
        guard let s = str else {
            return false
        }
        
        return self == s
    }
    
    
    
    public func isValidEmailString() -> Bool {
        if String.isNullOrEmpty(self) {
            return false
        }
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
