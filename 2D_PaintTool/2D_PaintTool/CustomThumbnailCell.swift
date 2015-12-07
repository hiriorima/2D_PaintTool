//
//  CustomCategoryCell.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/11/20.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class CustomThumbnailCell: UICollectionViewCell {

    @IBOutlet var thumbnail:UIImageView!
    @IBOutlet weak var img_name: UILabel!
    
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
}
