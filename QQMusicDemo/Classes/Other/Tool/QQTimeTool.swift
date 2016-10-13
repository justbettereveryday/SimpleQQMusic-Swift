//
//  QQTimeTool.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {
    class func getFormatTime(timeInterval : NSTimeInterval) -> String {
        let min = Int(timeInterval) / 60
        let sec = Int(timeInterval) % 60
        
        return String(format: "%02d: %02d", min , sec)
        
    }
    
    class func getTime(formatTime : String) -> NSTimeInterval {
        let minSec = formatTime.componentsSeparatedByString(":")
        if minSec.count == 2 {
            let min = Double(minSec[0])
            let sec = Double(minSec[1])
            return min! * 60 + sec!
        }
        return 0
        
    }
}
