//
//  DownloadDataHttpConnect.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class DownloadDataHttpConnect: BaseHttpConnect {

    fileprivate var saveFilePath: URL?
    
    func downloadDataWithURLRequest(request: URLRequest?, saveAtPath filePath: URL?) {
        guard let req = request, let path = filePath else {
            return
        }
        errorCode = .None
        saveFilePath = path
        let sessionConfig = URLSessionConfiguration.default
        
        session = URLSession(configuration: sessionConfig)
        sessionTask = session?.downloadTask(with: req)
        sessionTask?.resume()
        }
}

