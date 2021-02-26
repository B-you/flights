//
//  APIHelper.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 25/12/2019.
//  Copyright © 2019 Olasunkanmi Taiwo. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults
import SwiftKeychainWrapper
import ObjectMapper
import AlamofireObjectMapper

class APIHelper {
    
    static let BASE_URL = "https://myflightdata.com/api"
    
    /**
     Modify this enum to work with your own services.
     */
    enum API: String {
        case signin = "/SignIn"
        case Directories = "/Directories"
        case MyCurrencies = "/MyCurrencies"
        case MyTrainings = "/MyTrainings"
        case MySchedules = "/MySchedules"
        case FlightLogData = "/FlightLogData"
        case VerifyLimit = "/VerifyFlightLimits"
        case SaveLeg = "/SaveLeg"
    }
    
 
    static var token:String?
    static var fileprefix = "https://myflightdata.com/assets/EFB/"
    static var pilotid: String?
    static var operatorid: String?
    struct LoginParams: Encodable
    {
        let email: String
        let pass: String
    }
    
    /**
     Alamofire Manager in static var.
     */
    static var alamofireManager : Alamofire.SessionManager?
    
    /**
     Everything that you need to send in headers to your server. This is the place.
     */
    static func config() -> Alamofire.SessionManager{
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        //configuration.httpAdditionalHeaders = headers
        configuration.timeoutIntervalForRequest = 30;
        configuration.timeoutIntervalForResource = 30;
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        return alamofireManager!
    }
    
    /**
     Isn't this awesome, countries json is converted to array of CountryModel. You can use this methot for all GET requests in your app.
     Make sure you created a model for that request first.
     */
//    static func countries(onCompletion: ([CountryModel]?) -> Void){
//        let request = self.config().request(.GET, BASE_URL + API.countries.rawValue)
//        request.responseArray { (response: [CountryModel]?, error: ErrorType?) in
//            if response != nil {
//                onCompletion(response!)
//            } else {
//                onCompletion(nil)
//            }
//        }
//    }
//
    
    /**
     Modify this method to work with your own login service or just uncomment the below code if you use token auth.
     */
    static func SignIn(email: String, password:String, onCompletion: @escaping (Pilot?) -> Void){
        
        let request = self.config().request(BASE_URL + API.signin.rawValue, method: .post, parameters: ["email":email, "pass":password], encoding: JSONEncoding.default);
        
        request.responseJSON{
            response in
            let pilot = Mapper<Pilot>().map(JSONObject: response.result.value);
            if pilot != nil {
                onCompletion(pilot!)
            } else {
                print(response.result.value ?? "Nothing")
                onCompletion(nil)
            }
        }
    }
    
    
    static func GetFiles(onCompletion: @escaping ([EFBDirectory]?) -> Void){
        let headers: HTTPHeaders = [				
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.Directories.rawValue + "?pilot="+self.pilotid!+"&operator=" + self.operatorid!
        let request = self.config().request( url, method: .get, encoding: JSONEncoding.default, headers: headers);
        
        request.responseArray { (response: DataResponse<[EFBDirectory]>) -> Void in
            if response.result.isSuccess
            {
                if let data = response.result.value
                {
                    onCompletion(data);
                }
                else
                {
                    print (response);
                    onCompletion(nil);
                }
            }
            else
            {
                print (response);
                onCompletion(nil);
            }
        }
    }
    
    static func GetMyCurrencies(onCompletion: @escaping ([MyTraining]?) -> Void){
        let headers: HTTPHeaders = [
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.MyCurrencies.rawValue + "?pilot="+self.pilotid!+"&operator=" + self.operatorid!
        let request = self.config().request( url, method: .get, encoding: JSONEncoding.default, headers: headers);
        
        request.responseArray { (response: DataResponse<[MyTraining]>) -> Void in
            if response.result.isSuccess
            {
                if let data = response.result.value
                {
                    onCompletion(data);
                }
                else
                {
                    print (response);
                    onCompletion(nil);
                }
            }
            else
            {
                print (response);
                onCompletion(nil);
            }
        }
    }
    
    
    static func GetMyTrainings(onCompletion: @escaping ([MyTraining]?) -> Void){
        let headers: HTTPHeaders = [
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.MyTrainings.rawValue + "?pilot="+self.pilotid!+"&operator=" + self.operatorid!
        let request = self.config().request( url, method: .get, encoding: JSONEncoding.default, headers: headers);
        
        request.responseArray { (response: DataResponse<[MyTraining]>) -> Void in
            if response.result.isSuccess
            {
                if let data = response.result.value
                {
                    onCompletion(data);
                }
                else
                {
                    print (response);
                    onCompletion(nil);
                }
            }
            else
            {
                print (response);
                onCompletion(nil);
            }
        }
    }
    
    
    
    static func GetMySchedules(onCompletion: @escaping ([MySchedule]?) -> Void){
        let headers: HTTPHeaders = [
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.MySchedules.rawValue + "?pilot="+self.pilotid!+"&operator=" + self.operatorid!
        let request = self.config().request( url, method: .get, encoding: JSONEncoding.default, headers: headers);
        
        request.responseArray { (response: DataResponse<[MySchedule]>) -> Void in
            if response.result.isSuccess
            {
                if let data = response.result.value
                {
                    onCompletion(data);
                }
                else
                {
                    print (response);
                    onCompletion(nil);
                }
            }
            else
            {
                print (response);
                onCompletion(nil);
            }
        }
    }
    
    static func GetFlightData( onCompletion: @escaping (FlightLogData?) -> Void){
        
        let headers: HTTPHeaders = [
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.FlightLogData.rawValue + "?pilot="+self.pilotid!+"&operator=" + self.operatorid!
        let request = self.config().request( url, method: .get, encoding: JSONEncoding.default, headers: headers);
        
        
        request.responseJSON{
            response in
            let data = Mapper<FlightLogData>().map(JSONObject: response.result.value);
            if data != nil {
                onCompletion(data!)
            } else {
                print(response.result.value ?? "Nothing")
                onCompletion(nil)
            }
        }
    }
    
    static func VerifyLimit(data: VerifyLimit, onCompletion: @escaping (VerifyResponse?) -> Void){
        let headers: HTTPHeaders = [
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.VerifyLimit.rawValue
        let request = self.config().request(url, method: .post, parameters: data.toJSON(), encoding: JSONEncoding.default, headers: headers);
        
        request.responseJSON{
            response in
            let verify = Mapper<VerifyResponse>().map(JSONObject: response.result.value);
            if verify != nil {
                onCompletion(verify!)
            } else {
                print(response.result.value ?? "Nothing")
                onCompletion(nil)
            }
        }
    }
    
    
    static func SaveLeg(data: SaveLegModel, onCompletion: @escaping (SaveLegResponse?) -> Void){
        let headers: HTTPHeaders = [
            "X-API-KEY": self.token!
        ]
        let url = BASE_URL + API.SaveLeg.rawValue
        let request = self.config().request(url, method: .post, parameters: data.toJSON(), encoding: JSONEncoding.default, headers: headers);
        
        request.responseJSON{
            response in
            let leg = Mapper<SaveLegResponse>().map(JSONObject: response.result.value);
            if leg != nil {
                onCompletion(leg!)
            } else {
                print(response.result.value ?? "Nothing")
                onCompletion(nil)
            }
        }
    }
    
}

