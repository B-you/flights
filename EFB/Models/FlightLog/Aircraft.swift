//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class Aircraft:Mappable {
    
    var id: String?
    var custid: String?
    var aircrafttailnumber: String?
    var aircraft_type: String?
    var datecreated: String?
    var active: String?
    var initialtime: String?
    var status: String?
    var legtype: String?
    var trackmaintenancetime: String?
    var category: String?
    var aircraft_class: String?
    var startmaintenence: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        custid <- map["custid"]
        aircrafttailnumber <- map["aircrafttailnumber"]
        aircraft_type <- map["aircraft_type"]
        datecreated <- map["datecreated"]
        active <- map["active"]
        initialtime <- map["initialtime"]
        status <- map["status"]
        legtype <- map["legtype"]
        trackmaintenancetime <- map["trackmaintenancetime"]
        category <- map["category"]
        aircraft_class <- map["legtype"]
        startmaintenence <- map["startmaintenence"]
        
        
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

