//
//  CategoryButtonCell.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/12/07.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class CategoryButtonCell: UICollectionViewCell {

    @IBOutlet weak var CategoryButtonImg: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
}
