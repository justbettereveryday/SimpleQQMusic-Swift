//
//  QQMusicDataTool.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {
    //获取音乐信息
    class func getMusicModels(result : ([QQMusicModel]) -> ()){
        //解析歌曲信息
        //1. 获取文件路径
        guard let path = NSBundle.mainBundle().pathForResource("Musics.plist", ofType: nil) else {
            result([QQMusicModel]())
        return
        }
        
        //2. 读取文件内容
        guard let array = NSArray(contentsOfFile : path) else {
            result([QQMusicModel]())
            return
        }
        
        //3. 解析成歌曲
        var models = [QQMusicModel]()
        for dic in array {
            let model = QQMusicModel(dic: dic as! [String : AnyObject])
            models.append(model)
        }
        result(models)
    }
    
    class func getLrcMData(lrcName : String) -> [QQLrcModel] {
        //1.获取歌词文件路径
        guard let path = NSBundle.mainBundle().pathForResource(lrcName, ofType: nil) else {
            return [QQLrcModel]()
        }
        
        //2. 获取歌词文件的内容
        var lrcContent : String?
        do {
            lrcContent = try String(contentsOfFile: path)
        }catch{
            return [QQLrcModel]()
        }
        
        if lrcContent == nil {
            return [QQLrcModel]()
        }
        
        //3. 解析歌词
        var lrcMs = [QQLrcModel]()
        let lrcStrArray = lrcContent!.componentsSeparatedByString("\n")
        for lrcStr in lrcStrArray {
            //1. 过滤垃圾数据
            if lrcStr.containsString("[ti:") || lrcStr.containsString("[ar:") || lrcStr.containsString("[al:") {
                continue
            }
            
            //2. 处理正确数据
            let resultStr = lrcStr.stringByReplacingOccurrencesOfString("[", withString: "")
            let timeAndLrc = resultStr.componentsSeparatedByString("]")
            
            if timeAndLrc.count == 2 {
                let timeformat = timeAndLrc[0]
                let lrc = timeAndLrc[1]
                let lrcM = QQLrcModel()
                lrcM.startTime = QQTimeTool.getTime(timeformat)
                lrcM.lrcContent = lrc
                lrcMs.append(lrcM)
            }
        }
        
        for i in 0..<lrcMs.count {
            if i == (lrcMs.count - 1) {
                break
            }
            lrcMs[i].endTime = lrcMs[i + 1].startTime
        }
        
        return lrcMs
    }
    
    class func getRowLrcM(lrcMs : [QQLrcModel], currentTime : NSTimeInterval) -> (row : Int,lrcM : QQLrcModel?) {
        for i in 0..<lrcMs.count {
            if currentTime > lrcMs[i].startTime && currentTime < lrcMs[i].endTime {
                return(i,  lrcMs[i])
            }
        }
        
        return (0,nil)
    }
    
    
}















