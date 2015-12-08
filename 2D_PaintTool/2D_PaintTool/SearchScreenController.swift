//
//  SearchScreenController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/12/01.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//


import UIKit

class SearchScreenController: UIViewController{
    
    var thumbnailConfig:ThumbnailConfig?
    var categoryButtonConfig:CategoryButtonConfig?
    
    @IBOutlet weak var CategoryButtonCollection: UICollectionView!
    @IBOutlet weak var CategoryThumbnail: UICollectionView!
    
    @IBOutlet weak var homeButton: UIButton!
    
    let baseurl:String = "http://paint.fablabhakodate.org/imgshow?category="
    
    
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var finish_flag: Bool = false
        
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: baseurl+appDelegate.category_number!)!
        
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
                }
            } catch (let e) {
                print(e)
            }
            finish_flag = true
        })
        
        
        while(!finish_flag){
            usleep(10)
        }
        
        self.thumbnailConfig = ThumbnailConfig(items: images_url, imgs_name: images_name)
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
        
        appDelegate.viewController = self
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Reload(){
        
        var finish_flag: Bool = false
        
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: baseurl+appDelegate.category_number!)!
        
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
                }
            } catch (let e) {
                print(e)
            }
            finish_flag = true
        })
        
        
        while(!finish_flag){
            usleep(10)
        }
        
        self.thumbnailConfig = ThumbnailConfig(items: images_url, imgs_name: images_name)
        
        // self.CategoryThumbnail.reloadData()
        
    }
    
    
    func viewChange(){
        let sv = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("selectGraphic")
        
        sv.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        
        // Viewの移動する.
        self.presentViewController(sv, animated: true, completion: nil)

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
