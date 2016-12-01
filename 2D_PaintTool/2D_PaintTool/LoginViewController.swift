//
//  LoginViewController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/12/01.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,
UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet var IDInputField: UITextField!
    @IBOutlet var PWInputField: UITextField!
    @IBOutlet var sc: UIScrollView!
    @IBOutlet var Error: UILabel!
    
    private var txtActiveField = UITextField()
    
    let baseHost = "http://paint.fablabhakodate.org/"
    let oneYearInSeconds = NSTimeInterval(60 * 60 * 24 * 365)
    
    var login_id: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sc.frame = self.view.frame
        IDInputField.delegate = self
        PWInputField.delegate = self
        sc.delegate = self
        
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: "http://paint.fablabhakodate.org/noooo")!
        
        request.get(url, completionHandler: { data, response, error in
            // code
        })
        
        IDInputField.placeholder = "IDを入力してください(英数字3~10字)"
        PWInputField.placeholder = "パスワードを入力してください(英数字4~8字)"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    編集開始時の処理
    *パスワード入力方式設定
    *if:テキストフィールドをタップ
    テキストフィールド初期化
    */
    @IBAction func TextFieldEditingDidBegin(sender: UITextField) {
        txtActiveField = sender
        if(sender == PWInputField){
            sender.secureTextEntry = true}
    }
    
    
    /*
    テキストが編集された際に呼ばれる.
    */
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength: Int = 0
        
        // 文字数最大を決める.
        if(textField == IDInputField){
            maxLength = 11
        }else if(textField == PWInputField){
            maxLength = 9
        }
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str = textField.text! + string
        
        // 文字数がmaxLength以下ならtrueを返す.
        if str.characters.count < maxLength {
            return true
        }
        
        return false
    }
    
    
    /*
    キーボード以外をタップするとキーボードを閉じる
    */
    @IBAction func TapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    /*
    Returnをタップするとキーボードを閉じる
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    キーボード表示時にテキストフィールドと重なっているか調べる
    重なっていたらスクロールする
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(LoginViewController.handleKeyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(LoginViewController.handleKeyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        let txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
        let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
        
        if txtLimit >= kbdLimit {
            sc.contentOffset.y = txtLimit - kbdLimit
        }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
        sc.contentOffset.y = 0
    }
    
    
    @IBOutlet var LoginButton: SpringButton!
     var LoginFlag = (0,0)
    @IBAction func TapLoginButton(sender: AnyObject) {
        let String_ID = IDInputField.text
        let String_PW = PWInputField.text
        
        //エラー処理
        if String_ID!.characters.count >= 3{
            LoginFlag.0 =  1
        }else{
            LoginFlag.0 = 0}
        if String_PW?.characters.count >= 4 {
            LoginFlag.1 =  1
        }else{
            LoginFlag.1 = 0}
        
        LoginButton.animation = "shake"
        switch LoginFlag{
        case(0,0):
            Error.text = "IDとパスワードが違います"
            LoginButton.animate()
        case(1,0):
            Error.text = "パスワードが違います"
            LoginButton.animate()
        case(0,1):
            Error.text = "IDが違います"
            LoginButton.animate()
        case(1,1):
            Error.text = ""
            LoginActivity(String_ID!, password: String_PW!)
        default:
            Error.text = "エラーが発生しました。"
        }
        
        
    }
    
    /*
    * ログイン処理
    */
    func LoginActivity(userid: String, password: String){
        
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: "http://paint.fablabhakodate.org/signinuser")!
        
        let body: NSMutableDictionary = NSMutableDictionary()
        body.setValue(userid, forKey: "userid")
        body.setValue(password, forKey: "password")
        
        var login_flag = false
        var finish_flag = false
        
        request.post(url, body: body, completionHandler: { data, response, error in
            // code
            do {
                let json = try NSJSONSerialization.JSONObjectWithData((data)!, options: .MutableContainers) as! NSDictionary
                if json["userid"] != nil{
                    login_flag = true
                }else{
                    print(json)
                }
            } catch (let e) {
                print(e)
            }
            finish_flag = true
        })
        
        while(!finish_flag){
            usleep(10)
        }
        
        if(login_flag){
            self.ScreenTransition(userid)
        }else{
            //ToDo ログインできない
           // print("ログインできませんでした")
            Error.text = "IDまたはパスワードが違います"
            LoginButton.animation = "shake"
            LoginButton.animate()
        }
    }
    
    func ScreenTransition(userid:String){
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //appDelegateの変数を操作
        appDelegate.user_id = userid
        
        let HomeScreenViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
        
        // アニメーションを設定.
        HomeScreenViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        // Viewの移動する.
        self.presentViewController(HomeScreenViewController, animated: true, completion: nil)
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

