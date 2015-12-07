//
//  HomeScreenController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/12/01.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//


import UIKit

class HomeScreenController:UIViewController{
    
    var thumbnailConfig:ThumbnailConfig?
    
    @IBOutlet weak var ThumbnailCollection: UICollectionView!
    
    @IBOutlet weak var username: UILabel!
    
    var finish_flag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        username.text = appDelegate.user_id! + "   さん"
        
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: "http://paint.fablabhakodate.org/imgshow?category=-1")!
        
        // create ThumbnailCollection
        var images_url:Array<String> = []
        var images_name:Array<String> = []
        
        request.get(url, completionHandler: { data, response, error in
            // code
            do {
                let json = try NSJSONSerialization.JSONObjectWithData((data)!, options: .MutableContainers) as! NSArray
                
                for ( var i = 0, n = json.count ; i < n ; i++ ) {
                    let dictionary  = json[i]
                    images_url.append(dictionary["filedata"] as! String)
                    images_name.append(dictionary["title"] as! String)
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
        
        // set Usagi List
        self.thumbnailConfig = ThumbnailConfig(items: images_url,imgs_name: images_name)
        ThumbnailCollection.dataSource = self.thumbnailConfig
        ThumbnailCollection.delegate = self.thumbnailConfig
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}