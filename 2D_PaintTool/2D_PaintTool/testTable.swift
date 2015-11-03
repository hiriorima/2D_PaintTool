//
//  testTable.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/11/03.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import Foundation
import UIKit

class testTable: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table:UITableView!
    @IBOutlet var test: UILabel!
    
    let imgArray: NSArray = ["L_width1.png","L_width2.png","L_width3.png"]
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Table Viewのセルの数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    //各セルの要素を設定する
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
        let img = UIImage(named:"\(imgArray[indexPath.row])")
        // Tag番号 1 で UIImageView インスタンスの生成
        let imageView = table.viewWithTag(1) as! UIImageView
        imageView.image = img

               return cell
    }
    
     func tableView(table: UITableView, willDisplayCell cell: UITableViewCell,
        cellRowAtIndexPath indexPath: NSIndexPath) {
            
                cell.backgroundColor = UIColor.blackColor()
                }
    
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch indexPath.row{
        case 0:
            test.text = "small"
        case 1:
            test.text = "midium"
        case 2:
             test.text = "big"
        default:
            break
        }}
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}