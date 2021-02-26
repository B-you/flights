//
//  FileViewCell.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 29/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class FileViewCell: UITableViewCell {

    @IBOutlet weak var flFileName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
