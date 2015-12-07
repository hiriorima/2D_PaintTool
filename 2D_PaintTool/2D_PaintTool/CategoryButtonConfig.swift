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
       
        var searchscreen:SearchScreenController = SearchScreenController()
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        switch items[indexPath.row]{
        case "character.png":
            appDelegate.category_number = "0"
        case "plant.png":
            appDelegate.category_number = "1"
        case "eat.png":
            appDelegate.category_number = "2"
        case "human.png":
            appDelegate.category_number = "3"
        case "animal.png":
            appDelegate.category_number = "4"
        case "car.png":
            appDelegate.category_number = "5"
        case "mark.png":
            appDelegate.category_number = "6"
        case "etc.png":
            appDelegate.category_number = "7"
        default:
            break
        }
        
         searchscreen.Reload()

    }

}
