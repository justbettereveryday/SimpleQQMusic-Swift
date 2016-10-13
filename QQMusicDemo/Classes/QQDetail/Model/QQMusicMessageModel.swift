//
//  QQMusicMessageModel.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {
    var musicM : QQMusicModel?
    
    //已经播放的时间
    var costTime : NSTimeInterval = 0
    
    //总时长
    var totalTime : NSTimeInterval = 0
    
    //播放状态
    var isPlaying : Bool = false
        
}
