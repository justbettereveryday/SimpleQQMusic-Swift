//
//  QQMusicOperationTool.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

//MARK : 控制播放的业务逻辑
class QQMusicOperationTool: NSObject {
    
    static let shareInstance = QQMusicOperationTool()
    let tool = QQMusicTool()
    
    private var musicModel = QQMusicMessageModel()
    
    func getMusciMessageModel() -> QQMusicMessageModel {
        //当前正在播放的信息
        musicModel.musicM = musicMs[currentPlayIndex]
        musicModel.costTime = (tool.player?.currentTime) ?? 0
        musicModel.totalTime = (tool.player?.duration) ?? 0
        musicModel.isPlaying = (tool.player?.playing) ?? false
        
        return musicModel
    }
    
    var currentPlayIndex = -1{
        didSet{
            if currentPlayIndex < 0 {
                currentPlayIndex = (musicMs.count) - 1
            }
            if currentPlayIndex > (musicMs.count) - 1 {
                currentPlayIndex = 0
            }
        }
    }
    
    var musicMs : [QQMusicModel] = [QQMusicModel]()
    func playMusic(musicM : QQMusicModel) -> () {
        //播放数据模型对于的音乐
        tool.playMusic(musicM.filename)
        currentPlayIndex = musicMs.indexOf(musicM)!
    }
    
    func playCurrentMusic() -> () {
        //取出对应模型
        let model = musicMs[currentPlayIndex]
        playMusic(model)
    }
    
    //暂停
    func pause() -> () {
        tool.pauseMusic()
    }
    
    //下一首
    func nextMusic() -> () {
        currentPlayIndex += 1
        let model = musicMs[currentPlayIndex]
        playMusic(model)
    }
    
    func preMusci() -> () {
        currentPlayIndex -= 1
        let model = musicMs[currentPlayIndex]
        playMusic(model)
        
    }
    
}
