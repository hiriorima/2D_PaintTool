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
    
    init(items: Array<String>,imgs_name: Array<String>) {
        self.items = items
        self.imgs_name = imgs_name
        super.init()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CustomThumbnailCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomThumbnailCell
        
        
        let url = NSURL(string: items[indexPath.row]);
        print(items[indexPath.row])
       let data = NSData(contentsOfURL:url!)
        let img = UIImage(data: data!);
        
        // set Name
        cell.thumbnail.image = img
        cell.backgroundColor = UIColor.whiteColor()
        cell.img_name.text = imgs_name[indexPath.row]
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //Todo ここで画像データをデリゲートに投げて編集画面へ画面遷移する!!
        let url = NSURL(string: items[indexPath.row]);
        let data = NSData(contentsOfURL:url!)
        let img = UIImage(data: data!);
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
        appDelegate.searchImg = img
        
        appDelegate.viewController?.viewChange()
        
        
    }
}
