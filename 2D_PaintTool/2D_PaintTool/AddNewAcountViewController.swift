//
//  AddNewAcountController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/12/01.
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
        
        IDInputField.placeholder = "IDを入力してください(英数字3~10字)"
        PWInputField.placeholder = "パスワードを入力してください(英数字4~8字)"
        PWReinputField.placeholder = "パスワードをもう一度入力してください(英数字4~8字)"
        
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
        if(sender == PWInputField || sender == PWReinputField){
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
        }else if(textField == PWInputField || textField == PWReinputField){
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
        notificationCenter.addObserver(self, selector: #selector(AddNewAcountViewController.handleKeyboardWillShowNotification(_:)), name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(AddNewAcountViewController.handleKeyboardWillHideNotification(_:)), name: UIKeyboardWillHideNotification, object: nil)
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
    
    @IBOutlet var AddButton: SpringButton!
    var AddFlag = (0,0)
    @IBAction func TapAddNewAccount(sender: AnyObject) {
        
        let String_ID = IDInputField.text
        let String_PW = PWInputField.text
        let String_RePW = PWReinputField.text
        
        
        //エラー処理
        if String_ID!.characters.count >= 3{
            AddFlag.0 =  1
        }else{
            AddFlag.0 = 0}
        if String_PW!.characters.count >= 4 || String_RePW!.characters.count >= 4{
            AddFlag.1 =  1
        }else{
            AddFlag.1 = 0}
        
        AddButton.animation = "shake"
        switch AddFlag{
        case(0,0):
            ErrorLabel.text = "IDとパスワードが違います"
            AddButton.animate()
        case(1,0):
            ErrorLabel.text = "パスワードが違います"
            AddButton.animate()
        case(0,1):
            ErrorLabel.text = "IDが違います"
            AddButton.animate()
        case(1,1):
            if String_PW == String_RePW{
                ErrorLabel.text = ""
                AddNewAccountActivity(String_ID!, password: String_PW!,password_confirmation: String_RePW!);
            }else{
                ErrorLabel.text = "パスワードが一致していません"
                AddButton.animate()}
        default:
            ErrorLabel.text = "エラーが発生しました。"
        }

        
        
        
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
