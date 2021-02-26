//
//  ScheduleViewCell.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 11/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class ScheduleViewCell: UITableViewCell {

    @IBOutlet weak var From: UILabel!
    @IBOutlet weak var To: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Aircraft: UILabel!
    @IBOutlet weak var Note: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
