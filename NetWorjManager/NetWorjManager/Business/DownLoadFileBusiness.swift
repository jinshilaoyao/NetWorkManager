//
//  DownLoadFileBusiness.swift
//  NetWorjManager
//
//  Created by yesway on 2016/12/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class DownLoadFileBusiness: BaseBusiness {

    struct Content {
        static let HEADER_CONTENT_TYPE_NAME: String = "Content-Type"
        static let HEADER_CONTENT_TYPE_VALUE: String = "application/json;charset=utf-8"
        static let HEADER = [HEADER_CONTENT_TYPE_NAME: HEADER_CONTENT_TYPE_VALUE]
    }
    
    override init() {
        super.init()
        businessType = .BUSINESS_LOGIN
        baseHttpConnect = DownloadDataHttpConnect()
        baseHttpConnect?.delegate = self
    }
    
    override func execute(param: [String : AnyObject]?, withNtspHeader ntspHeader: NtspHeader?) {
        guard let dict = param else {
            return
        }
        
        if !JSONSerialization.isValidJSONObject(dict) {
            return
        }
        
        guard let header = ntspHeader?.toDicValue(), let connect = baseHttpConnect as? DownloadDataHttpConnect else {
            return
        }
        
        if (baseHttpConnect != nil) {
            let request = baseHttpConnect?.createURLRequestWithUrl(url: connectUrl, withSendData: nil, withHttpHeads: Content.HEADER as [String : AnyObject]?, withTimeOut: httpTimeout)
            connect.downloadDataWithURLRequest(request: request, saveAtPath:saveFilePath)
        }
    }
    
    
    
}
