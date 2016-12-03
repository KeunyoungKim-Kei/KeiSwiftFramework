//
//  KUserDefaultsSwitch.swift
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

open class KUserDefaultsSwitch: UISwitch {
    open override var isOn: Bool {
        didSet {
            if let key = userDefaultsKey {
                KKeyValueStore.saveBool(isOn, forKey: key)
            }
        }
    }
    
    @IBInspectable open var userDefaultsKey: String? = nil {
        didSet {
            update()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        update(false)
    }
    
    
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        update(false)
    }
    
    
    open override func setOn(_ on: Bool, animated: Bool) {
        super.setOn(on, animated: animated)
        
        if let key = userDefaultsKey {
            KKeyValueStore.saveBool(on, forKey: key)
        }
    }
    
    open func update(_ animated: Bool = true) {
        if let key = userDefaultsKey {
            let isTrue = KKeyValueStore.boolValue(key)
            print("UPDATE with \(key) \(isTrue)")
            setOn(isTrue, animated: animated)
        }
    }
}
