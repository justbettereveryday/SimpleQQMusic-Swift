//
//  QQLrcLabel.swift
//  QQMusicDemo
//
//  Created by SuperMaxLi on 16/9/19.
//  Copyright © 2016年 Li. All rights reserved.
//

import UIKit

class QQLrcLabel: UILabel {

    var progress : CGFloat = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        UIColor.greenColor().set()
        UIRectFillUsingBlendMode(CGRectMake(0, 0, rect.width * progress, rect.height), .SourceIn)
    }

}
