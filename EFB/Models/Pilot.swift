//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class Pilot:Mappable {
    
    var pilotid: String?
    var custid: String?
    var ids: String?
    var firstname: String?
    var lastname: String?
    var datecreated: String?
    var active: Int?
    var pilotcode: String?
    var email: String?
    var flighttimelimittype: String?
    var apikey: String?
    
    init() {
    }
    
    required init?(map: Map){
    }

   
    /**
     Map the model with JSON returned from server. More on https://github.com/Hearst-DD/ObjectMapper
     */
    func mapping(map: Map) {
        pilotid <- map["pilotid"]
        custid <- map["custid"]
        ids <- map["ids"]
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        datecreated <- map["datecreated"]
        active <- map["active"]
        pilotcode <- map["pilotcode"]
        email <- map["email"]
        flighttimelimittype <- map["flighttimelimittype"]
        apikey <- map["apikey"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

