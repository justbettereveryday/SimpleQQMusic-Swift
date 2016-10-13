//
//  QQDetailViewController.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQDetailViewController: UIViewController {
    //背景图1
    @IBOutlet weak var backImageView: UIImageView!
    //背景图2
    @IBOutlet weak var foreImageView: UIImageView!
    //歌词动画背景
    @IBOutlet weak var lrcScrollView: UIScrollView!
    //歌曲名称
    @IBOutlet weak var songNameLabel: UILabel!
    //歌手名称
    @IBOutlet weak var singerNameLabel: UILabel!
    //总时长
    @IBOutlet weak var totalTimeLabel: UILabel!
    //播放时长
    @IBOutlet weak var costTimeLabel: UILabel!
    //歌词label
    @IBOutlet weak var lrcLabel: QQLrcLabel!
    
    //歌词视图
    var lrcVc : QQLrcTableViewController = {
        return QQLrcTableViewController()
    }()
    
    @IBOutlet weak var playButton: UIButton!
    
    //进度
    @IBOutlet weak var progressSlider: UISlider!
    //负责更新的timer
    var timer : NSTimer?
    
    var displayLink : CADisplayLink?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupOnce()
        addTimer()
        addDisPlayLink()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加歌词视图
        addLrcView()
        //设置歌词动画
        setupScrollView()
        //设置进度条
        setSlider()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //移除定时器
        removeTimer()
        removeDisPlayLink()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

    //执行多次更新方法的定时器
    func addTimer() -> () {
        timer = NSTimer (timeInterval: 1, target: self, selector: #selector(QQDetailViewController.setupTimes), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }

    //移除定时器
    func removeTimer() -> () {
        timer?.invalidate()
        timer = nil
    }
    
    func addDisPlayLink() -> () {
        displayLink = CADisplayLink(target: self, selector: #selector( QQDetailViewController.updateLrcData))
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func removeDisPlayLink(){
        displayLink?.invalidate()
        displayLink = nil
    }
}

extension QQDetailViewController{
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func playOrPause(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            QQMusicOperationTool.shareInstance.playCurrentMusic()
            resumeRotation()
        }
        else{
            QQMusicOperationTool.shareInstance.pause()
            pauseRotation()
        }
    }
    
    
    @IBAction func preMusic(sender: AnyObject) {
        QQMusicOperationTool.shareInstance.preMusci()
        
        //切换一次歌曲，就更新一次界面
        setupOnce()
    }
    
    @IBAction func next() {
        QQMusicOperationTool.shareInstance.nextMusic()
        setupOnce()
    }
}

//MARK : 界面操作
extension QQDetailViewController{
    //系统重新布局子控件的方法，可以获取到最后正确的frame，一般把控件的布局，写到这里
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //设置歌词frame
        setLrcViewFrame()
        //设置前景图片圆角
        setupForeImageView()
    }
    
    //设置状态栏显示
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //设置进度条图标
    func setSlider() -> () {
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), forState: .Normal)
    }
    
    //设置前景图圆角效果
    func setupForeImageView() -> () {
        foreImageView.layer.cornerRadius = foreImageView.width * 0.5
        foreImageView.layer.masksToBounds = true
    }
    
    //添加歌词视图
    func addLrcView() -> () {
        lrcScrollView.addSubview(lrcVc.tableView)
    }
    
    //调整歌词视图frame
    func setLrcViewFrame(){
        lrcVc.tableView?.frame = lrcScrollView.bounds
        lrcVc.tableView?.x = lrcScrollView.width
        lrcScrollView.contentSize = CGSizeMake(lrcScrollView.width * 2, 0)
    }
    
    //设置scrollView的contentSize
    func setupScrollView() -> () {
        //设置代理
        lrcScrollView.delegate = self
        //设置分页
        lrcScrollView.pagingEnabled = true
        //隐藏水平滚动条
        lrcScrollView.showsHorizontalScrollIndicator = false
    }
}


//MARK : 切换歌曲逻辑处理
extension QQDetailViewController{
    //MARK : 切换歌曲时候，进行一次界面更新
    func setupOnce() -> () {
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusciMessageModel()
        guard let musicM = musicMessageM.musicM else {
            return
        }
        
        //背景图1处理
        if musicM.icon != nil {
            backImageView.image = UIImage(named: musicM.icon!)
            foreImageView.image = UIImage(named: musicM.icon!)
        }
        
        //歌曲名称
        songNameLabel.text = musicM.name
        
        //歌手名称
        singerNameLabel.text = musicM.singer
        
        //总时长
        totalTimeLabel.text = QQTimeTool.getFormatTime(musicMessageM.totalTime)
        
        //添加播放动画
        addRotation()
        if musicMessageM.isPlaying {
            resumeRotation()
        }
        else{
            pauseRotation()
        }
        
        //更新歌词
        let lrcMs = QQMusicDataTool.getLrcMData(musicM.lrcname!)
        
        lrcVc.lrcMs = lrcMs
        
    }
    
    //切换歌曲时候，需要更新N次操作
    func setupTimes() -> () {
        let musicM = QQMusicOperationTool.shareInstance.getMusciMessageModel()
        
        if playButton.selected != musicM.isPlaying {
            playButton.selected = musicM.isPlaying
            
            if musicM.isPlaying {
                resumeRotation()
            }
            else{
                pauseRotation()
            }
        }
        
        
        //进度条
        progressSlider.value = Float(musicM.costTime / musicM.totalTime)
        
        //播放时长
        costTimeLabel.text = QQTimeTool.getFormatTime(musicM.costTime)
    }
    
    func updateLrcData() -> () {
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusciMessageModel()
        
        //1. 拿到当前行号
        let rowLrcM = QQMusicDataTool.getRowLrcM(lrcVc.lrcMs, currentTime: musicMessageM.costTime)
        //2. 滚动到对应行
        lrcVc.scrollRow = rowLrcM.row
        
        //3. 更新歌词
        lrcLabel.text = rowLrcM.lrcM?.lrcContent
        
        //4.更新歌词进度
        if rowLrcM.lrcM != nil {
            let progressTime = CGFloat(musicMessageM.costTime - (rowLrcM.lrcM?.startTime)!)
            
            let totalTime = CGFloat((rowLrcM.lrcM?.endTime)! - (rowLrcM.lrcM?.startTime)!)
            
            lrcLabel.progress = progressTime / totalTime
            lrcVc.progress = lrcLabel.progress
            
        }
        
    }
    
}

extension QQDetailViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //当前移动量
        let x = scrollView.contentOffset.x
        //计算移动的比例
        let radio = 1 - x / scrollView.width
        
        foreImageView.alpha = radio
        lrcLabel.alpha = radio
    }
    
    //播放旋转动画
    func addRotation() -> () {
        foreImageView.layer.removeAnimationForKey("rotate")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2 * M_PI
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        animation.removedOnCompletion = false
        foreImageView.layer.addAnimation(animation, forKey: "rotation")
    }
    
    func pauseRotation() -> () {
        foreImageView.layer.pauseAnimation()
    }
    
    func resumeRotation() -> () {
        foreImageView.layer.resumeAnimation()
    }
}






