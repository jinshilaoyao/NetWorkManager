//
//  UserLoginBusiness.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/11.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class UserLoginBusiness: BaseBusiness {

    override init() {
        super.init()
        businessType = .BUSINESS_LOGIN
        connectUrl = "https://www.baidu.com"
        httpTimeout = 10
    }
}
