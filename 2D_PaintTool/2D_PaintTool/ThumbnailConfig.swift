//
//  CategoryConfig.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/11/20.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class ThumbnailConfig: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{

    
    var items:Array<String> = []
    var imgs_name:Array<String> = []
    
    init(items: Array<String>) {
        self.items = items
        super.init()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CustomThumbnailCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomThumbnailCell
        
        
        let url = NSURL(string: items[indexPath.row]);
        let data = NSData(contentsOfURL:url!)
        var img = UIImage(data: data!);
        
        // set Name
        cell.thumbnail.image = img
        cell.backgroundColor = UIColor.whiteColor()
        cell.img_name.text = "しらね"
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
}
