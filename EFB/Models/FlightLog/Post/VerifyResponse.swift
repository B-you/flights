//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class VerifyResponse:Mappable {
    
    var Check: Bool?
    var Medical: Bool?
    var Currency: Bool?
    var Pilot: String?
    var hourlimit: Bool?
    var Available: Bool?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        Check <- map["Check"]
        Medical <- map["Medical"]
        Currency <- map["Currency"]
        Pilot <- map["Pilot"]
        hourlimit <- map["hourlimit"]
        Available <- map["Available"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

