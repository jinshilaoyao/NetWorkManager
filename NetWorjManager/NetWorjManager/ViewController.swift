//
//  ViewController.swift
//  NetWorjManager
//
//  Created by yesway on 16/10/10.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let connect = BaseHttpConnect()
        
        let request = connect.createURLRequestWithUrl(url: "https://www.baidu.com", withSendData: nil, withHttpHeads: nil, withTimeOut: 7)
        
        connect.sendWithURLRequest(request: request!)
        
    }


}

