//
//  QQMusicCell.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/18.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

enum AnimationType {
    case Rotation
    case Transition
    case Scale
}

class QQMusicCell: UITableViewCell {

    var musicM : QQMusicModel?{
        didSet{
            singerIconImageView.image = UIImage(named: (musicM?.singerIcon)!)
            songNameLabel.text = musicM?.name
            singerNameLabel.text = musicM?.singer
        }
    }
    
    
    @IBOutlet weak var singerIconImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        singerIconImageView.layer.cornerRadius = 30
        singerIconImageView.layer.masksToBounds = true
    }
    
    class func cellWithTableView(tableView : UITableView) -> QQMusicCell{
        let cellID = "music"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? QQMusicCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("QQMusicCell", owner: nil, options: nil)!.first as? QQMusicCell
        }
        
        return cell!
    }
    
    func animationWithType(type:AnimationType) -> () {
        if type == .Rotation {
            self.layer.removeAnimationForKey("rotation")
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            animation.values = [-1/6 * M_PI, 0 , 1/6 * M_PI , 0]
            animation.duration = 0.2
            animation.repeatCount = 3
            self.layer.addAnimation(animation, forKey: "rotation")
        }
        if type == .Scale {
            self.layer.removeAnimationForKey("scale")
            let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            animation.values = [0.5, 1, 0.5, 1]
            animation.duration = 0.2
            animation.repeatCount = 1
            self.layer.addAnimation(animation, forKey: "scale")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
