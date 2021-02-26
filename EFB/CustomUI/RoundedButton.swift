//
//  RoundedButton.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedButton: UIButton
{
    override func layoutSubviews(){
        super.layoutSubviews();
        updateCornerRadius();
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet{
            updateCornerRadius();
        }
    }
    
    func updateCornerRadius(){
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0;
    }
}
