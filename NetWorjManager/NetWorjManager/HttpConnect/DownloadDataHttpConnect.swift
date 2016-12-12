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
extension DownloadDataHttpConnect: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let savePath = saveFilePath else {
            return
        }
        let fileManager = FileManager.default
        try? fileManager.moveItem(at: location, to: savePath)
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        delegate?.httpContentAtDownloading(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
    }
}

