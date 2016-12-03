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

open class KKeyboardObserverViewController: KViewController {
    
    open var keyboardFrame: CGRect = CGRect.zero
    open var keyboardAnimationDuration: CGFloat = 0.3
    
    open lazy var keyboardHideTapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(KKeyboardObserverViewController.handleTapGuesture(_:)))
    }()
    
    open var inputTargetView: UIView?
    
    
    open func onKeyboardWillShow() {
        
    }
    
    open func onKeyboardWillHide() {
        
    }
    
    
    open func attachTapGesture(_ view: UIView) {
        view.addGestureRecognizer(keyboardHideTapGesture)
    }
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Tap Gesture
    //
    func handleTapGuesture(_ tap: UITapGestureRecognizer) {
        findFirstResponderAndResign()
    }
    
    
    
    
    /////////////////////////////////////////////////////////////////////
    //
    // MARK: - Notification
    //
    open override func handleNotification(_ noti: Notification) {
        super.handleNotification(noti)
        
        switch noti.name {
        case NSNotification.Name.UIKeyboardWillShow:
            if let info = noti.userInfo {
                keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                keyboardAnimationDuration = CGFloat((info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).floatValue)
                
                DispatchQueue.main.async(execute: { [weak self] () -> Void in
                    self?.onKeyboardWillShow()
                    })
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(keyboardAnimationDuration * CGFloat(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { [weak self] () -> Void in
                    self?.inputTargetView = self?.findFirstResponder()
                    })
            }
        case NSNotification.Name.UIKeyboardWillHide:
            inputTargetView = nil
            
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
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
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotifications([NSNotification.Name.UIKeyboardWillShow.rawValue, NSNotification.Name.UIKeyboardWillHide.rawValue])
    }
    
    
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        findFirstResponderAndResign()
    }
}
