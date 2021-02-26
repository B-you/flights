//
//  DirectoryVM.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 27/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation

class DirectoryVM
{
    var DirectoryName: String?
    var Files: [FileVM] = [FileVM]()
}

class FileVM
{
    var FileName: String?
    var LastUpdated: Date?
    var LastUpdatedString: String?
    var FileSize: String?
    var FullPath: String?
}
