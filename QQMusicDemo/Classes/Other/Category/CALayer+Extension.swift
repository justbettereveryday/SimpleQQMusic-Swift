//
//  CALayer+Extension.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/19.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

extension CALayer{
    
    //暂停动画
    func pauseAnimation() -> () {
        let pauseTime : CFTimeInterval = convertTime(CACurrentMediaTime(), toLayer: nil)
        speed = 0.0
        timeOffset = pauseTime
    }
    
    //恢复动画
    func resumeAnimation() -> () {
        let pauseTime : CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause : CFTimeInterval = convertTime(CACurrentMediaTime(), toLayer: nil) - pauseTime
        
        beginTime = timeSincePause
        
        
    }
    
}
