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
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    @IBAction func Reset1(sender: AnyObject) {
        //appDelegateの変数を操作　円
        appDelegate.selectGraphic = 1
    }
    
    @IBAction func Reset2(sender: AnyObject) {
        appDelegate.selectGraphic = 2

    }
    
    
    @IBAction func Reset3(sender: AnyObject) {
        appDelegate.selectGraphic = 3

    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
   
}

