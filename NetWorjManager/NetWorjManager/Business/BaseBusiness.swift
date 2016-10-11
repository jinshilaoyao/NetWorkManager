//
//  BaseBusiness.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

enum BusinessError: Int {
    case NoError = 0
    case TimeError
    case InnerError
    case NessyError
    case AuthError
    case ParamError
    case UnknownError
    case DidAdd
    case Travelogue_Remove = 106
}

protocol DownloadBusinessDelegate: NSObjectProtocol {
    func didDownloadFileOfByteCount(business: BaseBusiness, forByteCount byteCount: Int, forTotalByteCount totalByteCount: Int)
}

protocol BusinessDelegate: NSObjectProtocol {
    func businessDidSuccess(business: BaseBusiness, withData businessData: [String: AnyObject]?)
    func businessDidError(business: BaseBusiness, withErrorCode businessErrorCode:BusinessError?, withHttpErrorCode httpErrorCode: HttpErrorCode?, withErrorMessage errMessage: String?)
}

class BaseBusiness: NSObject {
    
    fileprivate var businessErrorCode: BusinessError = .NoError
    fileprivate var errorMessage: String = ""
    private var baseHttpConnect: BaseHttpConnect?
    var connectUrl: String = ""
    var httpTimeout: Int = 0
    var businessType: BusinessType = .BUSINESS_LOGIN
    
    weak var delegate: BusinessDelegate?
    
    struct Content {
        static let HeadContentTypeName = "Content-Type"
        static let HeadContentTypeValue = "application/json;charset=utf-8"
    }
    
    override init() {
        super.init()
        
        baseHttpConnect = BaseHttpConnect()
        baseHttpConnect?.delegate = self
    }
    
    func execute(param: [String: AnyObject]?, withNtspHeader ntspHeader: NtspHeader?) {
        
        guard let dict = param else {
            return
        }
        
        if !JSONSerialization.isValidJSONObject(dict) {
            return
        }
        
        guard let header = ntspHeader?.toDicValue(), let connect = baseHttpConnect else {
            return
        }
        connect.delegate = self
        var httpBodyDic: [String: AnyObject] = [:]
        
        for key in dict.keys {
            if let value = dict[key] {
                httpBodyDic.updateValue(value, forKey: key)
            }
        }
        
        httpBodyDic.updateValue(header as AnyObject, forKey: "ntspheader")
        
        print("send url : \(connectUrl)")
        print("send body : \(httpBodyDic)")
        
        let headDic = Dictionary(dictionaryLiteral: (Content.HeadContentTypeName, Content.HeadContentTypeValue)) as [String: AnyObject]
        
        let httpBody = try? JSONSerialization.data(withJSONObject: httpBodyDic, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        guard let request = baseHttpConnect?.createURLRequestWithUrl(url: connectUrl, withSendData: httpBody, withHttpHeads: headDic, withTimeOut: httpTimeout) else {
            return
        }
        
        baseHttpConnect?.sendWithURLRequest(request: request)
    }
    
    func cancel() {
        if baseHttpConnect != nil {
            baseHttpConnect?.delegate = nil
            baseHttpConnect?.cancel()
        }
    }
    
    func parseBaseBusinessHttpConnectResponseData() -> [String: AnyObject]? {
        
        guard let data = baseHttpConnect?.respones.responesData else {
            return nil
        }
        
        return [String: AnyObject]()
//        return (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]) ?? nil

    }
    
    func getNtspHeaderFromBaseBusinessHttpConnectResponseData() -> NtspHeader? {
        
        guard let responseBodyDic = parseBaseBusinessHttpConnectResponseData(), let ntspHeaderDic = responseBodyDic["ntspheader"] as? [String: AnyObject] else {
            return nil
        }
        
        let ntspHeader = NtspHeader(json: ntspHeaderDic)
        
        return ntspHeader
    }
    
    func errorCodeFromResponse(theResponseBody: [String: AnyObject]?) {
        
        guard let ntspHeaderField = theResponseBody?["ntspheader"] as? [String: AnyObject] else {
            return
        }
        businessErrorCode = .UnknownError
        
        businessErrorCode = ntspHeaderField["errcode"] as! BusinessError
        errorMessage = ntspHeaderField["errmsg"] as! String
        
    }
}

extension BaseBusiness: HttpConnectDelegate {
    func httpContentAtDownloading(bytesWritten: Int64, totalBytesWritten: Int64) {
        
    }

    func httpConnectDidError(errorCode: HttpErrorCode) {
        errorMessage = "errorCode-\(errorCode)"
        delegate?.businessDidError(business: self, withErrorCode: BusinessError.NoError, withHttpErrorCode: errorCode, withErrorMessage: errorMessage)
        
    }
    func httpConnectDidFinish(httpContent: BaseHttpConnect) {
        
        guard let responseBodyDic = parseBaseBusinessHttpConnectResponseData() else {
            return
        }
        
        errorCodeFromResponse(theResponseBody: responseBodyDic)
        
        if businessErrorCode == .UnknownError || businessErrorCode == .TimeError {
            delegate?.businessDidError(business: self, withErrorCode: businessErrorCode, withHttpErrorCode: HttpErrorCode.Success, withErrorMessage: errorMessage)
        }
        
        delegate?.businessDidSuccess(business: self, withData: responseBodyDic)
    }
}
