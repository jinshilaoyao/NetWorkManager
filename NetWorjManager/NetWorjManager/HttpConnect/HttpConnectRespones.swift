//
//  HttpConnectRespones.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class HttpConnectRespones: NSObject {
    
    var responesHead: [String: AnyObject]?
    var responesData: Data?

    
    deinit {
        responesData = nil
        responesHead = nil
    }
}
