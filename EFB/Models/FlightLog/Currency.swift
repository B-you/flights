//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class Currency:Mappable {
    
    var type: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    /**
     Map the model with JSON returned from server. More on https://github.com/Hearst-DD/ObjectMapper
     */
    func mapping(map: Map) {
        type <- map["type"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

