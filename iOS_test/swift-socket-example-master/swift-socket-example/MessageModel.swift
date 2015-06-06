//
//  MessageModel.swift
//  swift-socket-example
//
//  Created by Yuta Akizuki on 2014/12/22.
//  Copyright (c) 2014年 ytakzk.me. All rights reserved.
//

import UIKit

class MessageModel: NSObject {
    let user_id:NSInteger
    let locate:String
    
    init(_user_id:NSInteger, _locate:String) {
        user_id = _user_id
        locate = _locate
    }
}
