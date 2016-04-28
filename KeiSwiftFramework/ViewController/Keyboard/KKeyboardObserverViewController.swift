//
//  KKeyboardObserverViewController.swift
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

public class KKeyboardObserverViewController: KViewController {
    
    public var keyboardFrame: CGRect = CGRectZero
    public var keyboardAnimationDuration: CGFloat = 0.3
    
    public lazy var keyboardHideTapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(KKeyboardObserverViewController.handleTapGuesture(_:)))
    }()
    
    public var inputTargetView: UIView?
    
    
    public func onKeyboardWillShow() {
        
    }
    
    public func onKeyboardWillHide() {
        
    }
    
    
    public func attachTapGesture(view: UIView) {
        view.addGestureRecognizer(keyboardHideTapGesture)
    }
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Tap Gesture
    //
    func handleTapGuesture(tap: UITapGestureRecognizer) {
        findFirstResponderAndResign()
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Notification
    //
    public override func handleNotification(noti: NSNotification) {
        super.handleNotification(noti)
        
        switch noti.name {
        case UIKeyboardWillShowNotification:
            if let info = noti.userInfo {
                keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
                keyboardAnimationDuration = CGFloat((info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue)
                
                dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
                    self?.onKeyboardWillShow()
                    })
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(keyboardAnimationDuration * CGFloat(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] () -> Void in
                    self?.inputTargetView = self?.findFirstResponder()
                    })
            }
        case UIKeyboardWillHideNotification:
            inputTargetView = nil
            
            dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
                self?.onKeyboardWillHide()
                })
        default:
            break
        }
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - VC Life Cycle
    //
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotifications([UIKeyboardWillShowNotification, UIKeyboardWillHideNotification])
    }
    
    
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        findFirstResponderAndResign()
    }
}
