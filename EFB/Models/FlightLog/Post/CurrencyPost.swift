//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class CurrencyPost:Mappable {
    
    var pilot: String?
    var currency: String?
    var number: String?
    
    init() {
    }
    
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        pilot <- map["pilot"]
        currency <- map["currency"]
        number <- map["number"]
    }
    
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

