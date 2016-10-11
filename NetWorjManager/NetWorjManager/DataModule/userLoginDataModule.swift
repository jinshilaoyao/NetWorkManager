//
//  userLoginDataModule.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/11.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

enum Gender: Int {
    case Male = 1
    case Famale = 0
}

class userLoginDataModule: BaseDataModule {
    
    var name: String?
    var gender: Gender = .Famale
    var number: String?
    
    func loginWith(phoneNumber: String) -> BusinessType {
        number = phoneNumber
        
        var dict = [String: AnyObject]()
        
        dict.updateValue(phoneNumber as AnyObject, forKey: "number")
        baseBusiness = createBusinessWithType(type: .BUSINESS_LOGIN)
        baseBusiness?.execute(param: dict, withNtspHeader: createNtspHeader())
        
        return .BUSINESS_LOGIN
    }
    
    func loginout() -> BusinessType {
        
        if number == nil {
            return .BUSINESS_NONE
        }
        
        var dict = [String: AnyObject]()
        dict.updateValue(number as AnyObject, forKey: "number")
        baseBusiness = createBusinessWithType(type: .BUSINESS_LOGINOUT)
        baseBusiness?.execute(param: dict, withNtspHeader: createNtspHeader())
        
        return .BUSINESS_LOGINOUT
    }
    
}
