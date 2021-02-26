//
//  Directories.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 26/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import ObjectMapper

class EFBDirectory:Mappable
{
    var DirectoryName: String?
    var Files: [EFBFile] = []
    
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    /**
     Map the model with JSON returned from server. More on https://github.com/Hearst-DD/ObjectMapper
     */
    func mapping(map: Map) {
        DirectoryName <- map["DirectoryName"]
        Files <- map["Files"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}
