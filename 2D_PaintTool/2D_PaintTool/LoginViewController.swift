//
//  LoginViewController.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/10/31.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,
    UITextFieldDelegate,UIScrollViewDelegate {

    @IBOutlet var IDInputField: UITextField!
    @IBOutlet var PWInputField: UITextField!
    @IBOutlet var sc: UIScrollView!
    
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
    if(sender == IDInputField){
    if(sender.text! == "IDを入力してください(英数字3~10字)"){
    sender.text = ""
    }
    }else if(sender == PWInputField){
    sender.secureTextEntry = true
    if(sender.text! == "パスワードを入力してください(英数字4~8字)"){
    sender.text = ""
    }
    }
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
    var str = textField.text! + string
    
    // 文字数がmaxLength以下ならtrueを返す.
    if str.characters.count < maxLength {
    return true
    }
    
    return false
    }
    
    /*
    編集終了時の処理
    *パスワード入力方式設定
    *if:なにも入力されていない
    テキストフィールドに入力する項目表示
    */
    @IBAction func TextFieldEditingDidEnd(sender: UITextField) {
    if(sender == IDInputField){
    if(sender.text! == ""){
    sender.text = "IDを入力してください(英数字3~10字)"
    }
    }else if(sender == PWInputField){
    if(sender.text! == ""){
    sender.secureTextEntry = false
    sender.text = "パスワードを入力してください(英数字4~8字)"
    }
    }
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
    notificationCenter.addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
    notificationCenter.addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyboardWillShowNotification(notification: NSNotification) {
    
    let userInfo = notification.userInfo!
    let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
    var txtLimit = txtActiveField.frame.origin.y + txtActiveField.frame.height + 8.0
    let kbdLimit = myBoundSize.height - keyboardScreenEndFrame.size.height
    
    if txtLimit >= kbdLimit {
    sc.contentOffset.y = txtLimit - kbdLimit
    }
    }
    
    func handleKeyboardWillHideNotification(notification: NSNotification) {
    sc.contentOffset.y = 0
    }

    @IBAction func TapLoginButton(sender: UIButton) {
       let String_ID = IDInputField.text
        let String_PW = PWInputField.text
        
        LoginActivity(String_ID!, password: String_PW!)
        
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
            //ToDo ログインできな〜〜〜い
            print("ログインできませんでした")
        }
}
    
    func ScreenTransition(userid:String){
            //AppDelegateのインスタンスを取得
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            //appDelegateの変数を操作
            appDelegate.user_id = userid
            
            let HomeScreenViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homescreen")
            
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
