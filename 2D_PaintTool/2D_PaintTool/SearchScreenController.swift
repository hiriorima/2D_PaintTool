//
//  SearchScreenController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/12/01.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//


import UIKit

class SearchScreenController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{
    
    var thumbnailConfig:ThumbnailConfig?
    
    @IBOutlet weak var CategoryButtonCollection: UICollectionView!
    @IBOutlet weak var CategoryThumbnail: UICollectionView!
    
    @IBOutlet weak var homeButton: UIButton!
    
    let baseurl:String = "http://paint.fablabhakodate.org/imgshow?category="
    
    @IBOutlet weak var selectCategoryImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    let categoryImg:Array<String> =
    ["character.png",
        "plant.png",
        "eat.png",
        "human.png",
        "animal.png",
        "car.png",
        "mark.png",
        "etc.png"]
    
    
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.viewController = self
        
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
                
                
                
                    for i in 0 ..< json.count{
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
        
        CategoryButtonCollection.dataSource = self
        CategoryButtonCollection.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Reload(categoryImgString: String,categoryString:String){
        
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
                
                    for i in 0 ..< json.count{
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
        
        // 表示する画像を設定する.
        let img = UIImage(named: categoryImgString)
        selectCategoryImg.image = img
        categoryName.text = categoryString
        
        
        dispatch_async(dispatch_get_main_queue(), {
            self.CategoryThumbnail.reloadData()
            self.CategoryThumbnail.dataSource = self.thumbnailConfig
            self.CategoryThumbnail.delegate = self.thumbnailConfig
        })
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:CategoryButtonCell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryButtonCell", forIndexPath: indexPath) as! CategoryButtonCell
        
        let img = UIImage(named: categoryImg[indexPath.row]);
        
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
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var categoryString: String = ""
        
        switch categoryImg[indexPath.row]{
        case "character.png":
            appDelegate.category_number = "0"
            categoryString = "キャラクター"
        case "plant.png":
            appDelegate.category_number = "1"
        categoryString = "しょくぶつ"
        case "eat.png":
            appDelegate.category_number = "2"
            categoryString = "たべもの"
        case "human.png":
            appDelegate.category_number = "3"
            categoryString = "じんぶつ"
        case "animal.png":
            appDelegate.category_number = "4"
            categoryString = "どうぶつ"
        case "car.png":
            appDelegate.category_number = "5"
            categoryString = "のりもの"
        case "mark.png":
            appDelegate.category_number = "6"
            categoryString = "マーク"
        case "etc.png":
            appDelegate.category_number = "7"
            categoryString = "そのた"
        default:
            break
        }
        
        Reload(categoryImg[indexPath.row],categoryString: categoryString)
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
