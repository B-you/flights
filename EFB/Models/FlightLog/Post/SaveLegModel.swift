//
//  SaveLegModel.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class SaveLegModel:Mappable {
    
    var request_pilot : String?
    var request_operator: String?
    var aircraft: String?
    var out_time: String?
    var notes: String?
    var performed: String?
    var performed_nvg: String?
    var start_maint: String?
    var end_maint: String?
    var actt: String?
    var descripancy: String?
    var ret_service: String?
    var maint_status: Bool?
    var maint_type: String?
    var total_cycles: String?
    
    var legs: [LegPost] = []
    var currencies: [CurrencyPost] = []
    var pilots: [PilotCPS] = []
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        request_pilot <- map["request_pilot"]
        request_operator <- map["request_operator"]
        aircraft <- map["aircraft"]
        out_time <- map["out_time"]
        notes <- map["notes"]
        performed <- map["performed"]
        performed_nvg <- map["performed_nvg"]
        start_maint <- map["start_maint"]
        end_maint <- map["end_maint"]
        actt <- map["actt"]
        descripancy <- map["descripancy"]
        ret_service <- map["ret_service"]
        maint_status <- map["maint_status"]
        maint_type <- map["maint_type"]
        total_cycles <- map["total_cycles"]
        legs <- map["legs"]
        currencies <- map["currencies"]
        pilots <- map["pilots"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

