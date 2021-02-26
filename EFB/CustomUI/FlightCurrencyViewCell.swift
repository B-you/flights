//
//  FlightCurrencyViewCell.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 13/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit
import iOSDropDown

class FlightCurrencyViewCell: UITableViewCell {

    
    private var optionCurrency: [String] = [];
    private var optionNoOfTimes: [String] = [];
    
    @IBOutlet weak var drpCurrency: DropDown!
    @IBOutlet weak var drpNumber: DropDown!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
