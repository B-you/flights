//
//  Extensions.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 11/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    func showActivityIndicator(){
        let activityView = UIActivityIndicatorView(style: .gray)
        self.backgroundView = activityView
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        self.backgroundView = nil
    }
    
    func adjustHeight(_ addh: CGFloat){
        let height = self.contentSize.height

        //Expand Parent Height Constraint
        if(self.superview != nil){
            //Check for the height constraint
            if let c = self.superview?.constraints.first(where: {$0.firstAttribute == .height && $0.relation == .equal}){
                let h = c.constant + addh//(height - self.frame.height)
                c.constant = CGFloat(h)
                self.superview?.layoutIfNeeded()
            }
        }
//
        if let c = self.constraints.first(where: {$0.firstAttribute == .height && $0.relation == .equal}){
            let h = c.constant + addh//(height - self.frame.height)
            c.constant = CGFloat(h)
            self.layoutIfNeeded()
        }
//        var frame = self.frame
//        frame.size.height = height
//        self.frame = frame
//        self.layoutIfNeeded()
    }
}

extension UIView{
    func setHeight(_ h:CGFloat, animateTime:TimeInterval?=nil){
        if let c = self.constraints.first(where: {$0.firstAttribute == .height && $0.relation == .equal}){
            c.constant = CGFloat(h)
            if let animateTime = animateTime{
                UIView.animate(withDuration: animateTime, animations:{
                    self.superview?.layoutIfNeeded()
                })
            } else {
                self.superview?.layoutIfNeeded()
            }
        }
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor:UIColor? {
        get{
            if let color = self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor{
                return color
            }
            return nil
        }
        
        set (setOptionalColor){
            if let setColor = setOptionalColor{
                let string = self.placeholder ?? ""
                self.attributedPlaceholder = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: setColor])
            }
        }
    }
}
