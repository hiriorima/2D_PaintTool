//
//  HomeScreenController.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/11/06.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class SearchScreenController: UIViewController{

    var thumbnailConfig:ThumbnailConfig?
    var categoryButtonConfig:CategoryButtonConfig?
    
    @IBOutlet weak var CategoryButtonCollection: UICollectionView!
    @IBOutlet weak var CategoryThumbnail: UICollectionView!
    
    
    @IBOutlet weak var homeButton: UIButton!
    
    var finish_flag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request: Request = Request()
        
        let url: NSURL = NSURL(string: "http://paint.fablabhakodate.org/imgshow?category=1")!
        
        // create ThumbnailCollection
        var images_url:Array<String> = []
        
        request.get(url, completionHandler: { data, response, error in
            // code
            do {
                let json = try NSJSONSerialization.JSONObjectWithData((data)!, options: .MutableContainers) as! NSArray
                
                for ( var i = 0, n = json.count ; i < n ; i++ ) {
                    let dictionary  = json[i]
                    images_url.append(dictionary["filedata"] as! String)
                    
                    print(images_url)
                }
            } catch (let e) {
                print(e)
            }
            self.finish_flag = true
        })
        
        
        while(!finish_flag){
            usleep(10)
        }
        
        self.thumbnailConfig = ThumbnailConfig(items: images_url)
        CategoryThumbnail.dataSource = self.thumbnailConfig
        CategoryThumbnail.delegate = self.thumbnailConfig
        
        let categoryImg:Array<String> =
        ["character.png",
            "plant.png",
            "eat.png",
            "human.png",
            "animal.png",
        "car.png",
        "mark.png",
        "etc.png"]

      self.categoryButtonConfig = CategoryButtonConfig(items: categoryImg)
        CategoryButtonCollection.dataSource = self.categoryButtonConfig
        CategoryButtonCollection.delegate = self.categoryButtonConfig
        
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
