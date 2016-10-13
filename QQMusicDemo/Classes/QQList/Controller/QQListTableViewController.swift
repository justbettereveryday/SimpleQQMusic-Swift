//
//  QQListTableViewController.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/14.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQListTableViewController: UITableViewController {

    var musicMs : [QQMusicModel] = [QQMusicModel](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        QQMusicDataTool.getMusicModels { (models : [QQMusicModel]) in
            self.musicMs = models
            QQMusicOperationTool.shareInstance.musicMs = models
        }
    }
}

extension QQListTableViewController{
    func setupUI() -> () {
        setupTableView()
        
        navigationController?.navigationBarHidden = true
    }
    
    func setupTableView() -> () {
        let imageView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        tableView.backgroundView = imageView
        tableView.rowHeight = 60
        tableView.separatorStyle = .None
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension QQListTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicMs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = QQMusicCell.cellWithTableView(tableView)
        
        
        let model = musicMs[indexPath.row]
        cell.musicM = model
        cell.animationWithType(.Scale)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = musicMs[indexPath.row]
        QQMusicOperationTool.shareInstance.playMusic(model)
        performSegueWithIdentifier("listToDetail", sender: nil)
    }
}



