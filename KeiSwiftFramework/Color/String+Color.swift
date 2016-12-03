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
        
        let notAHexCharSet = CharacterSet(charactersIn: "0123456789ABCDEFabcdef#").inverted
        if let _ = rangeOfCharacter(from: notAHexCharSet) {
            return false
        }
        
        return true
    }
    
    
    
    public var redComponent: CGFloat? {
        if isHexColorString {
            var range: ClosedRange<String.Index>?
            
            switch characters.count {
            case 4:
                range = characters.index(startIndex, offsetBy: 1)...characters.index(startIndex, offsetBy: 1)
            case 5:
                range = characters.index(startIndex, offsetBy: 2)...characters.index(startIndex, offsetBy: 2)
            case 7:
                range = characters.index(startIndex, offsetBy: 1)...characters.index(startIndex, offsetBy: 2)
            case 9:
                range = characters.index(startIndex, offsetBy: 3)...characters.index(startIndex, offsetBy: 4)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(Range<String.Index>(uncheckedBounds: (componentRange.lowerBound, componentRange.upperBound)))
            }
        }
        
        return nil
    }
    
    
    
    public var greenComponent: CGFloat? {
        if isHexColorString {
            var range: ClosedRange<String.Index>?
            
            switch characters.count {
            case 4:
                range = characters.index(startIndex, offsetBy: 2)...characters.index(startIndex, offsetBy: 2)
            case 5:
                range = characters.index(startIndex, offsetBy: 3)...characters.index(startIndex, offsetBy: 3)
            case 7:
                range = characters.index(startIndex, offsetBy: 3)...characters.index(startIndex, offsetBy: 4)
            case 9:
                range = characters.index(startIndex, offsetBy: 5)...characters.index(startIndex, offsetBy: 6)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(Range<String.Index>(uncheckedBounds: (componentRange.lowerBound, componentRange.upperBound)))
            }
        }
        
        return nil
    }
    
    
    
    public var blueComponent: CGFloat? {
        if isHexColorString {
            var range: ClosedRange<String.Index>?
            
            switch characters.count {
            case 4:
                range = characters.index(startIndex, offsetBy: 3)...characters.index(startIndex, offsetBy: 3)
            case 5:
                range = characters.index(startIndex, offsetBy: 4)...characters.index(startIndex, offsetBy: 4)
            case 7:
                range = characters.index(startIndex, offsetBy: 5)...characters.index(startIndex, offsetBy: 6)
            case 9:
                range = characters.index(startIndex, offsetBy: 7)...characters.index(startIndex, offsetBy: 8)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(Range<String.Index>(uncheckedBounds: (componentRange.lowerBound, componentRange.upperBound)))
            }
        }
        
        return nil
    }
    
    
    
    public var alphaComponent: CGFloat? {
        if isHexColorString {
            var range: ClosedRange<String.Index>?
            
            switch characters.count {
            case 5:
                range = index(startIndex, offsetBy: 1)...index(startIndex, offsetBy: 1)
            case 9:
                range = index(startIndex, offsetBy: 1)...index(startIndex, offsetBy: 2)
            default:
                break
            }
            
            if let componentRange = range {
                return parseHex(Range<String.Index>(uncheckedBounds: (componentRange.lowerBound, componentRange.upperBound)))
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
        
        if let r = redComponent, let g = greenComponent, let b = blueComponent {
            return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a/255)
        }
        
        return nil
    }
    
    
    
    fileprivate func parseHex(_ range: Range<Index>) -> CGFloat? {
        var value = substring(with: range)
        if value.characters.count == 1 {
            value = value + value
        }
        
        var result: UInt32 = 0
        let scanner = Scanner(string: value)
        if scanner.scanHexInt32(&result) {
            return CGFloat(result)
        }
        
        return nil
    }
}
