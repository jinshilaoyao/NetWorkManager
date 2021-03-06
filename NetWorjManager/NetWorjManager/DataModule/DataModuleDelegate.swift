//
//  DataModuleDelegate.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/11.
//  Copyright © 2016年 joker. All rights reserved.
//
import UIKit

protocol DataModuleDelegate: NSObjectProtocol{
    
    func didDataModuelNoticeSuccess(baseDataModule: BaseDataModule, forBusinessType businessID: BusinessType)
    func didDataModuelNoticeFail(baseDataModule: BaseDataModule, forBusinessType businessID: BusinessType, forErrorMessage errorMsg: String)
}
protocol DataModuleDownloadDelegate: NSObjectProtocol {
    func didDataModuleNoticeDownLoadFiling(baseDataModule: BaseDataModule, for byteCount: Int64, totalByteCount: Int64, totalByteExpectedCount: Int64)
}
