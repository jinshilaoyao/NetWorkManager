//
//  ViewController.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let user = userLoginDataModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        user.delegate = self
        user.downLoadDelegate = self
        user.loginWith(phoneNumber: "adsf")
        
    }
}

extension ViewController: DataModuleDelegate {
    
    func didDataModuelNoticeSuccess(baseDataModule: BaseDataModule, forBusinessType businessID: BusinessType) {
        
    }
    
    func didDataModuelNoticeFail(baseDataModule: BaseDataModule, forBusinessType businessID: BusinessType, forErrorMessage errorMsg: String) {
        
    }
}
extension ViewController: DataModuleDownloadDelegate {
    func didDataModuleNoticeDownLoadFiling(baseDataModule: BaseDataModule, for byteCount: Int64, totalByteCount: Int64, totalByteExpectedCount: Int64) {
        
    }
}


