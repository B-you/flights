//
//  DateFormatTransform.swift
//  EFB
//
//  Created by Olasunkanmi Taiwo on 12/01/2021.
//  Copyright © 2021 Olasunkanmi Taiwo. All rights reserved.
//

import Foundation
import ObjectMapper

public class DateFormatTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    var dateFormat = DateFormatter()
    
    convenience init(dateFormat: String){
        self.init()
        self.dateFormat = DateFormatter()
        self.dateFormat.dateFormat = dateFormat //"yyyy-MM-dd HH:mm:ss"
    }
    
    public func transformFromJSON(_ value: Any?) -> Date? {
        let dateString =   value as! String?
        if (dateString != nil){
            return self.dateFormat.date(from: dateString!)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Date?) -> JSON? {
        let date = value
        if(date != nil){
            return self.dateFormat.string(from: date!)
        }
        return nil
    }
}
