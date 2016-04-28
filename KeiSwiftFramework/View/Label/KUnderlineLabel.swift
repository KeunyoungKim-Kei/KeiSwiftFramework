//
//  KUnderlineLabel.swift
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

@IBDesignable public class KUnderlineLabel: UIView {
    private let label = UILabel()
    private let underlineView = UIView()
    private var userConstraint = [NSLayoutConstraint]()
    
    
    
    @IBInspectable public var text: String?  {
        didSet {
            label.text = text
        }
    }
    
    
    
    @IBInspectable public var topMargin: Double = 10 {
        didSet {
            setupView()
        }
    }
    
    
    
    @IBInspectable public var bottomMargin: Double = 10 {
        didSet {
            setupView()
        }
    }
    
    
    
    @IBInspectable public var underlineHidden: Bool = false {
        didSet {
            setupView()
        }
    }
    
    
    
    @IBInspectable public var fontSize: CGFloat = 13 {
        didSet {
            label.font = UIFont.systemFontOfSize(fontSize)
        }
    }
    
    
    
    @IBInspectable public var textColor: UIColor = UIColor(red: 35.0/255.0, green: 39.0/255.0, blue: 57.0/255.0, alpha: 1.0) {
        didSet {
            label.textColor = textColor
        }
    }
    
    
    
    @IBInspectable public var underlineColor: UIColor = UIColor(red: 149.0/255.0, green: 150.0/255.0, blue: 156.0/255.0, alpha: 1.0) {
        didSet {
            underlineView.backgroundColor = underlineColor
        }
    }
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    
    
    func setupView() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
        if userConstraint.count > 0 {
            removeConstraints(userConstraint)
            userConstraint.removeAll(keepCapacity: false)
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(fontSize)
        label.textColor = textColor
        label.text = text
        
        addSubview(label)
        
        if underlineHidden == false {
            underlineView.translatesAutoresizingMaskIntoConstraints = false
            underlineView.userInteractionEnabled = false
            underlineView.backgroundColor = underlineColor
            
            addSubview(underlineView)
        }
        
        let metrics = ["top": NSNumber(double: topMargin), "bottom": NSNumber(double: bottomMargin)]
        let views = ["label": label, "underline": underlineView]
        
        var horz = NSLayoutConstraint.constraintsWithVisualFormat("|[label]|", options: [], metrics: nil, views: views)
        addConstraints(horz)
        
        if underlineHidden {
            let vert = NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[label]-bottom-|", options: [], metrics: metrics, views: views)
            addConstraints(vert)
        }
        else {
            horz = NSLayoutConstraint.constraintsWithVisualFormat("|[underline]|", options: [], metrics: nil, views: views)
            addConstraints(horz)
            
            let vert = NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[label]-bottom-[underline(1)]|", options: [], metrics: metrics, views: views)
            addConstraints(vert)
        }
    }
}

