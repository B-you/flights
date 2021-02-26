//
//  DirectoryRowControllerTableViewCell.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 28/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import UIKit

class DirectoryViewCell: UITableViewCell {

    @IBOutlet weak var txFolderName: UILabel!
    @IBOutlet weak var txTotalFiles: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //sgMtoFile
    }

}
