//
//  SaveLegResponse.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class SaveLegResponse:Mappable {
    
    var Check: Bool?
    var Message: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        Check <- map["Check"]
        Message <- map["Message"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

