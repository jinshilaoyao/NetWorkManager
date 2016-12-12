//
//  BusinessFactory.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/11.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class BusinessFactory: NSObject {

    class func createBusiness(type: BusinessType) -> BaseBusiness? {
        if type == .BUSINESS_LOGIN {
            return UserLoginBusiness()
        } else if type == .BUSINESS_LOGINOUT {
            return UserLoginBusiness()
        } else if type == .BUSINESS_USER_DOWNLOAD {
            return DownLoadFileBusiness()
        }
        return nil
    }
}
