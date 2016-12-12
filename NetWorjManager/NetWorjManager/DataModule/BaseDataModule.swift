//
//  BaseDataModule.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/11.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class BaseDataModule: NSObject, BusinessDelegate {

    private var sessionFail: Bool = false
    private var connectFail: Bool = false
    private var resquestFail: Bool = false
    
    
    weak var delegate: DataModuleDelegate?
    weak var downLoadDelegate: DataModuleDownloadDelegate?
    
    var baseBusiness: BaseBusiness?
    
    func createBusinessWithType(type: BusinessType) -> BaseBusiness? {
        
        guard let business = BusinessFactory.createBusiness(type: type) else {
            return nil
        }
        business.delegate = self
        business.downLoadDelegate = self
        return business
    }
    
    func createNtspHeader() -> NtspHeader? {
        let header = NtspHeader()
        header.sessionid = "001"
        header.userid = "AZ001"
        return header
    }
    
    
    func businessDidSuccess(business: BaseBusiness, withData businessData: [String : AnyObject]?) {
        delegate?.didDataModuelNoticeSuccess(baseDataModule: self, forBusinessType: business.businessType)
    }
    
    func businessDidError(business: BaseBusiness, withErrorCode businessErrorCode: BusinessError?, withHttpErrorCode httpErrorCode: HttpErrorCode?, withErrorMessage errMessage: String?) {
        if httpErrorCode == HttpErrorCode.Session_Fail {
            sessionFail = true
        } else if httpErrorCode != HttpErrorCode.Success && httpErrorCode != HttpErrorCode.None {
            connectFail = true
        } else if httpErrorCode == HttpErrorCode.TimeOut {
            resquestFail = true
        }
        
        delegate?.didDataModuelNoticeFail(baseDataModule: self, forBusinessType: business.businessType, forErrorMessage: errMessage!)
    }
}
extension BaseDataModule: DownloadBusinessDelegate {
    func httpConnectAtDownloadingWriteData(byresWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        downLoadDelegate?.didDataModuleNoticeDownLoadFiling(baseDataModule: self, for: byresWritten, totalByteCount: totalBytesWritten, totalByteExpectedCount: totalBytesExpectedToWrite)
    }
}
