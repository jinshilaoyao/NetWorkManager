//
//  NtspHeader.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class NtspHeader: NSObject {
    var apiKey: String = "aa"
    var version: String = "1.0.0"
    var sessionid: String = ""
    var userid: String = ""
    var errCode: Int = 0
    var errMsg: String = ""
    
    func toDicValue() -> [String: AnyObject]? {
        
        var dict = [String: AnyObject]()
        dict.updateValue(apiKey as AnyObject, forKey: "apikey")
        dict.updateValue(version as AnyObject, forKey: "version")
        dict.updateValue(sessionid as AnyObject, forKey: "sessionid")
        return dict
    }
    
    override init() {
        super.init()
    }
    
    convenience init(json: [String: AnyObject]) {
        self.init()
        setValuesForKeys(json)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
