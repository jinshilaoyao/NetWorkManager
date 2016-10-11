//
//  BaseHttpConnect.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import Foundation
class BaseHttpConnect: NSObject {
    fileprivate var dataBuffer: Data
    var errorCode: HttpErrorCode = .None
    var sessionTask: URLSessionTask?
    var session: URLSession?
    
    private var activityState: URLSessionTask.State {
        if sessionTask != nil {
            return (sessionTask?.state)!
        } else {
            return .canceling
        }
    }
    
    weak var delegate: HttpConnectDelegate?
    
    var respones: HttpConnectRespones
    
    override init() {
        dataBuffer = Data()
        respones = HttpConnectRespones()
        super.init()
    }
    
    func createURLRequestWithUrl(url: String, withSendData sendData: Data?, withHttpHeads heads: [String: AnyObject]?, withTimeOut timeOut: Int) -> URLRequest? {
        
        var timeOut = timeOut
        if timeOut <= 0 {
            timeOut = 15
        }
        
        guard let resquesUrl = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: resquesUrl, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: TimeInterval(timeOut))
        
        if sendData != nil {
            request.httpBody = sendData
            request.httpMethod = "POST"
        } else {
            request.httpMethod = "GET"
        }
        
        guard let dict = heads else {
            return request
        }
        
        for key in dict.keys {
            if let headValue = dict[key] {
                request.setValue(headValue as? String, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    func sendWithURLRequest(request: URLRequest) {
        errorCode = .None
        
        let sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)
        sessionTask = session?.dataTask(with: request)
        sessionTask?.resume()
    }
    
    func cancel() {
        sessionTask?.cancel()
        session?.invalidateAndCancel()
        session = nil
        
        respones = HttpConnectRespones()
        dataBuffer = Data()
    }

}
extension BaseHttpConnect: URLSessionDelegate, URLSessionDataDelegate {

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        completionHandler(URLSession.ResponseDisposition.allow)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        errorCode = HttpErrorCode(rawValue: httpResponse.statusCode) ?? .None
        print("the response status code is \(httpResponse.statusCode)")
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        dataBuffer.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error != nil || errorCode != HttpErrorCode.Success {
            // TODO: - 怎么获取error中的code
            delegate?.httpConnectDidError(errorCode: errorCode)
        } else {
            print("the connection is \(dataBuffer.count)")
            let result = String(data: dataBuffer, encoding: .utf8)
            print(result)
            respones.responesData = dataBuffer
            delegate?.httpConnectDidFinish(httpContent: self)
        }
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let card = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, card)
        }
    }
    
}

protocol HttpConnectDelegate: NSObjectProtocol {
    
    func httpConnectDidError(errorCode: HttpErrorCode)
    func httpConnectDidFinish(httpContent: BaseHttpConnect)
    func httpContentAtDownloading(bytesWritten: Int64, totalBytesWritten: Int64)
    
}
