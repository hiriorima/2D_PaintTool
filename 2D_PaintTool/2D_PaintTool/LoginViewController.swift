//
//  LoginViewController.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/10/31.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    テキストフィールドが編集された直後の処理
    */
    @IBAction func IDInputFieldEditingDidBegin(sender: UITextField) {
        if(sender.text! == ""){
            sender.text = "IDを入力してください"
        }
    }
    
    @IBAction func PWInputFieldEditingDidBegin(sender: UITextField) {
        if(sender.text! == ""){
            sender.secureTextEntry = false
            sender.text = "パスワードを入力してください"
        }
    }
    
   /*
    編集開始時の処理
    */
    @IBAction func IDInputFieldTouchDown(sender: UITextField) {
        if(sender.text! == "IDを入力してください"){
            sender.text = ""
        }
    }
    @IBAction func PWInputFieldTouchDown(sender: UITextField) {
        if(sender.text! == "パスワードを入力してください"){
            sender.text = ""
        }
        sender.secureTextEntry = true
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
