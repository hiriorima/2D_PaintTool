//
//  SearchScreenController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/12/01.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//


import UIKit

class SearchScreenController: UIViewController{
    
    var categoryConfig:CategoryConfig?
    
    @IBOutlet weak var CategoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create Usagi
        var items:Array<String> = []
        for ( var i = 1, n = 20 ; i <= n ; i++ ) {
            items.append("Usagi"+i.description)
        }
        
        // set Usagi List
        self.categoryConfig = CategoryConfig(items: items)
        self.CategoryCollection.dataSource = self.categoryConfig
        self.CategoryCollection.delegate = self.categoryConfig
        // CategoryCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
