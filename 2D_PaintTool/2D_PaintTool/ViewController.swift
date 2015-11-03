//
//  ViewController.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/10/30.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    var selectGraphicImage : UIImage?
    
    @IBAction func rect1(sender: AnyObject) {
        selectGraphicImage = UIImage(named: "Reset3.png")
        if selectGraphicImage != nil{
            
            performSegueWithIdentifier("toSubViewController",sender: nil)
        }
        
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toRPaint") {
            let PaintC: PaintController = (segue.destinationViewController as? PaintController)!
            // SubViewController のselectedImgに選択された画像を設定する
            PaintC.selectGraphicImg = selectGraphicImage
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
   
}

