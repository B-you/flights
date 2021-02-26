//
//  EFBFile.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 26/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import ObjectMapper

class EFBFile:Mappable{
    var id: String?
    var operatorid: String?
    var directoryid: String?
    var filename: String?
    var directoryname: String?
    var url: String?
    var datecreated: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    /**
     Map the model with JSON returned from server. More on https://github.com/Hearst-DD/ObjectMapper
     */
    func mapping(map: Map) {
        id <- map["id"]
        operatorid <- map["operatorid"]
        directoryid <- map["directoryid"]
        filename <- map["filename"]
        directoryname <- map["directoryname"]
        url <-  map["url"]
        datecreated <- map["datecreated"]
        url = APIHelper.fileprefix + (url ?? "")
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}
