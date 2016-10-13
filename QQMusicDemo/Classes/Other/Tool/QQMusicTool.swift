//
//  QQMusicTool.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit
import AVFoundation

//MARK : 控制具体播放状态
class QQMusicTool: NSObject {
    var player : AVAudioPlayer?
    
    func playMusic(musicName : String?) -> () {
        
        //1. 创建播放器
        guard let url = NSBundle.mainBundle().URLForResource(musicName, withExtension: nil) else{return}
        
        if player?.url == url {
            player?.play()
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
            player?.prepareToPlay()
            player?.play()
        }
        catch{
            print(error)
            return
        }
    }
    
    func pauseMusic(){
        player?.pause()
    }
    
}
