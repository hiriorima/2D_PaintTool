//
//  CategoryButtonConfig.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/12/07.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class CategoryButtonConfig: NSObject,
    UICollectionViewDataSource, UICollectionViewDelegate{
    
    var items:Array<String> = []
    
    init(items: Array<String>) {
    self.items = items
    super.init()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell:CategoryButtonCell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryButtonCell", forIndexPath: indexPath) as! CategoryButtonCell
    
    let img = UIImage(named: items[indexPath.row]);
    
    // set Name
    cell.CategoryButtonImg.image = img
    cell.backgroundColor = UIColor.greenColor()
    
    return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }

}
