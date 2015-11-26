//
//  HomeScreen.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/11/25.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class HomeScreenController:UIViewController{

    var categoryConfig:CategoryConfig?
    
    @IBOutlet weak var ThumbnailCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create Usagi
        var items:Array<String> = []
        for ( var i = 1, n = 20 ; i <= n ; i++ ) {
            items.append("Usagi"+i.description)
        }
        
        // set Usagi List
        //  self.categoryConfig = CategoryConfig(items: items)
        self.ThumbnailCollection.dataSource = self.categoryConfig
        self.ThumbnailCollection.delegate = self.categoryConfig
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
