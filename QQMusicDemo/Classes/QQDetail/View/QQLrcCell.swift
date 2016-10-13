//
//  QQLrcCell.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/19.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQLrcCell: UITableViewCell {

    @IBOutlet weak var lrcLabel: QQLrcLabel!

    var progress : CGFloat = 0{
        didSet{
            lrcLabel.progress = progress
        }
    }
    
    var lrcM : QQLrcModel?{
        didSet{
            lrcLabel.text = lrcM?.lrcContent
        }
    }
    
    class func cellWithTableView(tableView : UITableView) -> QQLrcCell {
        let ID = "LRC"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? QQLrcCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("QQLrcCell", owner: nil, options: nil)?.first as? QQLrcCell
        }
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
