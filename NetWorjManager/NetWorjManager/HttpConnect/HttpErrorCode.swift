//
//  HttpErrorCode.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//


enum HttpErrorCode: Int {
    case NetWorkFail = -1004
    case None = 0
    case Success = 200
    case TimeOut = -1001
    case Session_Fail = 401
}
