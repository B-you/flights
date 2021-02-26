//
//  LegPost.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class LegPost:Mappable {
    
    var type: String?
    var from: String?
    var to: String?
    var out: String?
    var `in`: String?
    var block: String?
    var next_day: Bool?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        type <- map["type"]
        from <- map["from"]
        to <- map["to"]
        out <- map["out"]
        `in` <- map["in"]
        block <- map["block"]
        next_day <- map["next_day"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

