//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class MyTraining:Mappable {
    var id: Int?
    var pilotid: Int?
    var custid: Int?
    var pilotname: String?
    var type: String?
    var Expr1: String?
    var reportid: String?
    var due: Date?
    var alertdays: Int?
    var completed: Date?
    var comment: String?
    var lastupdated: Date?
    var frequencyType: String?
    var frequency: Int?
    var itemtype: String?
    var daystildue: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        pilotid <- map["pilotid"]
        custid <- map["custid"]
        pilotname <- map["pilotname"]
        type <- map["type"]
        Expr1 <- map["Expr1"]
        reportid <- map["reportid"]
        alertdays <- map["alertdays"]
        comment <- map["comment"]
        frequencyType <- map["frequencyType"]
        frequency <- map["frequency"]
        itemtype <- map["itemtype"]
        daystildue <- map["daystildue"]
        
        
        due <- (map["due"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
        completed <- (map["completed"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
        lastupdated <- (map["lastupdated"], DateFormatTransform(dateFormat: "yyyy-MM-dd HH:mm:ss"))
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

