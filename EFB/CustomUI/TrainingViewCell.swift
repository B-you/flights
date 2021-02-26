//
//  TrainingViewCell.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 11/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class TrainingViewCell: UITableViewCell {

    @IBOutlet weak var ItemType: UILabel!
    @IBOutlet weak var DueDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
