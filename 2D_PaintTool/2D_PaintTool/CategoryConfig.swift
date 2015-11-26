//
//  CategoryConfig.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/11/20.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class CategoryConfig: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{

    
    var items:Array<String> = []
    
    init(items: Array<String>) {
        self.items = items
        super.init()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCategoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCategoryCell
        
        // set Name
        cell.name.text = self.items[indexPath.row];
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count;
    }
}
