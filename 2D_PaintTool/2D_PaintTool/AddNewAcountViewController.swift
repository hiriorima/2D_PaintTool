//
//  AddNewAcountViewController.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/10/31.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class AddNewAcountViewController: UIViewController, UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet var IDInputField: UITextField!
    @IBOutlet var PWInputField: UITextField!
    @IBOutlet var PWReinputField: UITextField!
    @IBOutlet var sc: UIScrollView!
    
    private var txtActiveField = UITextField()
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sc.frame = self.view.frame
        IDInputField.delegate = self
        PWInputField.delegate = self
        PWReinputField.delegate = self
        sc.delegate = self
        
        ErrorLabel.numberOfLines = 3
        
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
        }else if(sender == PWReinputField){
            sender.secureTextEntry = true
            if(sender.text! == "パスワードをもう一度入力してください(英数字4~8字)"){
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
        }else if(textField == PWInputField || textField == PWReinputField){
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
        }else if(sender == PWReinputField){
            if(sender.text! == ""){
                sender.secureTextEntry = false
                sender.text = "パスワードをもう一度入力してください(英数字4~8字)"
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
   
    
    @IBAction func TapAddNewAccount(sender: UIButton) {
        
        let String_ID = IDInputField.text
        let String_PW = PWInputField.text
        let String_RePW = PWReinputField.text
        
        //何も入力していない場合,英数字以外が入力されている場合
    /*    if(String_ID == "IDを入力してください(英数字3~10字)"){
            ErrorLabel.text = "IDを入力してください"
        }else if(String_PW == "パスワードを入力してください(英数字4~8字)"){
            ErrorLabel.text = "パスワードを入力してください"
        }else if(String_RePW == "パスワードをもう一度入力してください(英数字4~8字)"){
            ErrorLabel.text = "パスワードをもう一度入力してください"
        }else if(String_ID ){
            AddNewAccount();
        }*/
        
        AddNewAccountActivity(String_ID!, password: String_PW!,password_confirmation: String_RePW!);
    }
    
    func AddNewAccountActivity(userid:String ,password:String, password_confirmation:String){
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: "http://paint.fablabhakodate.org/adduser")!
        let body: NSMutableDictionary = NSMutableDictionary()
        body.setValue(userid, forKey: "userid")
        body.setValue(password, forKey: "password")
        body.setValue(password_confirmation, forKey: "password_confirmation")
        
        request.post(url, body: body, completionHandler: { data, response, error in
            // code
        })
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
