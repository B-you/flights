//
//  CustomSwitch.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 14/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomSwitch: UISwitch{
    @IBInspectable var scale : CGFloat = 1 {
        didSet{
            setup()
        }
    }
    
    //From storyboard
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //from code
    override init (frame: CGRect){
        super.init(frame: frame)
    }
    
    private func setup(){
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
        super.prepareForInterfaceBuilder()
    }
}
