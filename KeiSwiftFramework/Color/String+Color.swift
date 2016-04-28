//
//  String+Color.swift
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
    public var isHexColorString: Bool {
        if String.isNullOrEmpty(self) {
            return false
        }
        
        if !hasPrefix("#") {
            return false
        }
        
        let len = characters.count
        if len != 4 && len != 5 && len != 7 && len != 9 {
            return false
        }
        
        let notAHexCharSet = NSCharacterSet(charactersInString: "0123456789ABCDEFabcdef#").invertedSet
        if let _ = rangeOfCharacterFromSet(notAHexCharSet) {
            return false
        }
        
        return true
    }
    
    
    
    public var redComponent: CGFloat? {
        if isHexColorString {
            var range: Range<Index>?
            
            switch characters.count {
            case 4:
                range = startIndex.advancedBy(1)...startIndex.advancedBy(1)
            case 5:
                range = startIndex.advancedBy(2)...startIndex.advancedBy(2)
            case 7:
                range = startIndex.advancedBy(1)...startIndex.advancedBy(2)
            case 9:
                range = startIndex.advancedBy(3)...startIndex.advancedBy(4)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(componentRange)
            }
        }
        
        return nil
    }
    
    
    
    public var greenComponent: CGFloat? {
        if isHexColorString {
            var range: Range<Index>?
            
            switch characters.count {
            case 4:
                range = startIndex.advancedBy(2)...startIndex.advancedBy(2)
            case 5:
                range = startIndex.advancedBy(3)...startIndex.advancedBy(3)
            case 7:
                range = startIndex.advancedBy(3)...startIndex.advancedBy(4)
            case 9:
                range = startIndex.advancedBy(5)...startIndex.advancedBy(6)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(componentRange)
            }
        }
        
        return nil
    }
    
    
    
    public var blueComponent: CGFloat? {
        if isHexColorString {
            var range: Range<Index>?
            
            switch characters.count {
            case 4:
                range = startIndex.advancedBy(3)...startIndex.advancedBy(3)
            case 5:
                range = startIndex.advancedBy(4)...startIndex.advancedBy(4)
            case 7:
                range = startIndex.advancedBy(5)...startIndex.advancedBy(6)
            case 9:
                range = startIndex.advancedBy(7)...startIndex.advancedBy(8)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(componentRange)
            }
        }
        
        return nil
    }
    
    
    
    public var alphaComponent: CGFloat? {
        if isHexColorString {
            var range: Range<Index>?
            
            switch characters.count {
            case 5:
                range = startIndex.advancedBy(1)...startIndex.advancedBy(1)
            case 9:
                range = startIndex.advancedBy(1)...startIndex.advancedBy(2)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(componentRange)
            }
        }
        
        return nil
    }
    
    
    
    public var UIColorValue: UIColor {
        let color = parseHexColorString()
        assert(color != nil, "INVALID HEX COLOR STRING!")
        
        return color!
    }
    
    
    
    public func parseHexColorString() -> UIColor? {
        let a = alphaComponent ?? 255
        
        if let r = redComponent, g = greenComponent, b = blueComponent {
            return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a/255)
        }
        
        return nil
    }
    
    
    
    private func parseHex(range: Range<Index>) -> CGFloat? {
        var value = substringWithRange(range)
        if value.characters.count == 1 {
            value = value + value
        }
        
        var result: UInt32 = 0
        let scanner = NSScanner(string: value)
        if scanner.scanHexInt(&result) {
            return CGFloat(result)
        }
        
        return nil
    }
}