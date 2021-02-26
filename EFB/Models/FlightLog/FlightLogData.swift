//
//  Directories.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 26/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightLogData:Mappable
{
    var Currencies: [Currency] = []
    var CrewPositions: [CrewPosition] = []
    var Aircrafts: [Aircraft] = []
    var LegTypes: [LegType] = []
    
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    /**
     Map the model with JSON returned from server. More on https://github.com/Hearst-DD/ObjectMapper
     */
    func mapping(map: Map) {
        Currencies <- map["Currencies"]
        CrewPositions <- map["CrewPositions"]
        Aircrafts <- map["Aircrafts"]
        LegTypes <- map["LegTypes"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}
