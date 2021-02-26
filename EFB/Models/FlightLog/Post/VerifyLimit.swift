//
//  Pilot.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//



import Foundation
import ObjectMapper

class VerifyLimit:Mappable {
    
    var request_pilot : String?
    var request_operator: String?
    var txPilotCPS: [PilotCPS] = [] // "[{\"pilot\":\"21124\",\"cpos\":\"1\"}]",
    var txMaintType: String?
    var txCurrencies: [CurrencyPost] = [] //"[{\"pilot\":\"21124\",\"currency\":\"90 DAYS TO/LNG\",\"number\":\"6\"}]",
    var drpCrewPosition: String?
    var drpPerformed: String?
    var drpPerformedNVG: String?
    var drpAircraft: String?
    var dtOutTime: String? // "01/08/2021",
    var txStartMaint: String?
    var txEndMaint: String?
    var txtACTT: String?
    var drpLegType1: String?
    var txFrom1: String?
    var txTo1: String?
    var tmOut1: String?
    var tmIn1: String?
    var chNDay1: Bool?
    var txBlock1: String?
    var drpLegType2: String?
    var txFrom2: String?
    var txTo2: String?
    var tmOut2: String?
    var tmIn2: String?
    var chNDay2: Bool?
    var txBlock2: String?
    var txTotalCycles: String?
    var txNotes: String?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    
    func mapping(map: Map) {
        request_pilot <- map["request_pilot"]
        request_operator <- map["request_operator"]
        txPilotCPS <- map["txPilotCPS"]
        txMaintType <- map["txMaintType"]
        txCurrencies <- map["txCurrencies"]
        drpCrewPosition <- map["drpCrewPosition"]
        drpPerformed <- map["drpPerformed"]
        drpPerformedNVG <- map["drpPerformedNVG"]
        drpAircraft <- map["drpAircraft"]
        dtOutTime <- map["dtOutTime"]
        txStartMaint <- map["txStartMaint"]
        txEndMaint <- map["txEndMaint"]
        txtACTT <- map["txtACTT"]
        drpLegType1 <- map["drpLegType1"]
        txFrom1 <- map["txFrom1"]
        txTo1 <- map["txTo1"]
        tmOut1 <- map["tmOut1"]
        tmIn1 <- map["tmIn1"]
        chNDay1 <- map["chNDay1"]
        txBlock1 <- map["txBlock1"]
        drpLegType2 <- map["drpLegType2"]
        txFrom2 <- map["txFrom2"]
        txTo2 <- map["txTo2"]
        tmOut2 <- map["tmOut2"]
        tmIn2 <- map["tmIn2"]
        chNDay2 <- map["chNDay2"]
        txBlock2 <- map["txBlock2"]
        txTotalCycles <- map["txTotalCycles"]
        txNotes <- map["txNotes"]
    }
    
    /**
     Convert model to JSON String if you need to send it to server.
     */
    func toJSONString() -> String{
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

