//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class MySchedule:Mappable {
    
    
    var id: String?
    var pilotid: String?
    var custid: String?
    var scheduleflightid: String?
    var leg_out_time: Date?
    var leg_off_time: Date?
    var leg_on_time: Date?
    var leg_in_time: Date?
    var departure_airport: String?
    var arrival_airport: String?
    var firstname: String?
    var lastname: String?
    var aircrafttailnumber: String?
    var ids: String?
    var noofpassengers: String?
    var notes: String?
    
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
        custid <- map["custid"]
        scheduleflightid <- map["scheduleflightid"]
        leg_out_time <- (map["leg_out_time"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
        leg_off_time <- (map["leg_off_time"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
        leg_on_time <- (map["leg_on_time"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
        leg_in_time <- (map["leg_in_time"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
        departure_airport <- map["departure_airport"]
        arrival_airport <- map["arrival_airport"]
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        aircrafttailnumber <- map["aircrafttailnumber"]
        ids <- map["ids"]
        noofpassengers <- map["noofpassengers"]
        notes <- map["notes"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

