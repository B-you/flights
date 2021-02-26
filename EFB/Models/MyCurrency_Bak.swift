//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class MyCurrency_Bak:Mappable {
    
    
    var id: Int?
    var pilotid: Int?
    var aircraftid: Int?
    var currency_name: String?
    var custid: Int?
    var frequency: Int?
    var date: String?
    var legid: Int?
    var ids: String?
    var pilotname: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    /**
     Map the model with JSON returned from server. More on https://github.com/Hearst-DD/ObjectMapper
     */
    func mapping(map: Map) {
        id <- map["id"]
        pilotid <- map["pilotid"]
        aircraftid <- map["aircraftid"]
        currency_name <- map["currency_name"]
        custid <- map["custid"]
        frequency <- map["frequency"]
        date <- map["date"]
        legid <- map["legid"]
        ids <- map["ids"]
        pilotname <- map["pilotname"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

