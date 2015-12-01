//
//  PaintController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/10/30.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit
import ACEDrawingView

class PaintController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UIToolbarDelegate{


    // view & button　の宣言
    @IBOutlet var drawingView: ACEDrawingView!
    @IBOutlet var MenuList: SpringView!
    @IBOutlet var User: UIImageView!
    @IBOutlet var Username: UILabel!
    
    
    
    
    @IBOutlet var Ellipse_S: UIButton!
    @IBOutlet var Ellipse_F: UIButton!
    @IBOutlet var Rect_S: UIButton!
    @IBOutlet var Rect_F: UIButton!
    
    @IBOutlet var L_width1: UIButton!
    @IBOutlet var L_width2: UIButton!
    @IBOutlet var L_width3: UIButton!
    


    
    @IBOutlet var Reset: SpringButton!
    @IBOutlet var UnDo: UIButton!
    @IBOutlet var ReDo: UIButton!
    
    // 保存フラグ
    var SaveFlag = (0,0)

    
    
    @IBOutlet var Tooltable: UITableView!
     let TImgArray: NSArray = ["Menu.png","Pen.png","Line.png","Ellipse.png","Rect.png","Eraser.png","Text.png"]
    
    
   
    @IBOutlet var SaveView: SpringView!
    let CategoryArray: NSArray = ["キャラクター","しょくぶつ","たべもの","じんぶつ","どうぶつ","のりもの","まーく","そのた"]
        
    
    
    // 背景色の設定
    let select = UIColor.lightGrayColor()
    let clear = UIColor.clearColor()
    
    // 初期設定
    override func viewDidLoad() {
        super.viewDidLoad()

        // 赤の枠線
        drawingView.layer.borderColor = UIColor.redColor().CGColor
        drawingView.layer.borderWidth = 4.0
        
        // 図形ボタンの非表示
        Ellipse_S.hidden = true
        Ellipse_F.hidden = true
        Rect_S.hidden = true
        Rect_F.hidden = true
        
        // メニューリスト&セーブウインドウの非表示
        MenuList.hidden = true
        SaveView.hidden = true
        
        //選択中背景の初期設定
        L_width1.backgroundColor = select
        // テーブルのスクロール固定
        Tooltable.scrollEnabled = false
        
        //保存の初期設定
        TitleField.delegate = self
        let pickerView = UIPickerView()
        pickerView.delegate = self
        CategoryField.inputView = pickerView
        
        
       
        myToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        myToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        myToolBar.backgroundColor = UIColor.blackColor()
        myToolBar.barStyle = UIBarStyle.Black
        myToolBar.tintColor = UIColor.whiteColor()
        
        //ToolBarを閉じるボタンを追加
        let myToolBarButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "onClick:")
        myToolBarButton.tag = 1
        myToolBar.items = [myToolBarButton]
        
        //TextFieldをpickerViewとToolVerに関連づけ
        CategoryField.inputAccessoryView = myToolBar
        saveButton.layer.cornerRadius = 8
    }
    
    //画面が表示される直前//
     override func viewWillAppear(animated: Bool){
        
        //選択領域の概形選択&リセットボタンの画像設定
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
        let selectGraphic = appDelegate.selectGraphic
        
        switch selectGraphic{
        case 1:
            self.drawingView.layer.cornerRadius = 325
            self.drawingView.layer.masksToBounds = true
        case 2:
            drawingView.frame = CGRectMake(170, 100, 700, 550)
        case 3:
            drawingView.frame = CGRectMake(187, 62, 650, 650)
        default:
            ErrorWindow()
            }
        
        //Userの種類と名前の表示
        let UserID: String = ""
        let Guest:UIImage? = UIImage(named: "Guest.png")
        let Member:UIImage? = UIImage(named: "Member.png")
        if(UserID != ""){
        User.image = Member
        Username.text = UserID
            
        }else{
        User.image = Guest
        Username.text = "Guest"
        }
        
        // 検索からの画像ロード
       /* let SImg: UIImage
        if SImg != nil{
        drawingView.loadImage(SImg)
        }*/
        

        
        
        
    }
    
    @IBAction func MenuBack(sender: AnyObject) {
        CollisionDetection(MenuList, ONOFF: true)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    // 円(線のみ)
    @IBAction func EllipseStroke(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypeEllipseStroke
        Ellipse_S.hidden = true
        Ellipse_F.hidden = true
    }

    // 円(塗りつぶし)
    @IBAction func EllipseFill(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypeEllipseFill
        Ellipse_S.hidden = true
        Ellipse_F.hidden = true
    }
    
    // 四角(線のみ)
    @IBAction func RectStroke(sender: AnyObject) {
         drawingView.drawTool = ACEDrawingToolTypeRectagleStroke
         Rect_S.hidden = true
         Rect_F.hidden = true
    }
    
    // 四角(塗りつぶし)
    @IBAction func RectFill(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypeRectagleFill
        Rect_S.hidden = true
        Rect_F.hidden = true
    
    }
    
    
    
    

    // 戻る
    @IBAction func UnDo(sender: AnyObject) {
        drawingView.undoLatestStep()}
    
    // 進む
    @IBAction func ReDo(sender: AnyObject) {
    drawingView.redoLatestStep()}
    
    
    // 線の太さ
    @IBAction func Width1(sender: AnyObject) {
        drawingView.lineWidth = 10.0
        L_width1.backgroundColor = select
        L_width2.backgroundColor = clear
        L_width3.backgroundColor = clear
    }
   
    @IBAction func Width2(sender: AnyObject) {
        drawingView.lineWidth = 20.0
        L_width1.backgroundColor = clear
        L_width2.backgroundColor = select
        L_width3.backgroundColor = clear
    }

    @IBAction func Width3(sender: AnyObject) {
        drawingView.lineWidth = 30.0
        L_width1.backgroundColor = clear
        L_width2.backgroundColor = clear
        L_width3.backgroundColor = select
    }
    
    
    // 全消し
   
    @IBAction func Reset(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Clear", message: "編集したデータを全て削除し、\n白紙に戻しますか?", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default) {
            action in
            
            self.drawingView.clear()
            self.Reset.animation = "flipX"
            self.Reset.animate()
            
        }
        let cancellAction = UIAlertAction(title: "Cancell", style: .Cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        alertController.addAction(cancellAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    // ToolTable作成 //
    //Table Viewのセルの数を指定
    func tableView(Tooltable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TImgArray.count
    }
    
    //各セルの要素を設定する
    func tableView(Tooltable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = Tooltable.dequeueReusableCellWithIdentifier("TtableCell", forIndexPath: indexPath)
        
        let Timg = UIImage(named:"\(TImgArray[indexPath.row])")
        // Tag番号 1 で UIImageView インスタンスの生成
        let TimageView = Tooltable.viewWithTag(1) as! UIImageView
        TimageView.image = Timg
        
        //ToolTableCell選択時のバックカラーの変更
        let cellSelectedBgView = UIView()
        cellSelectedBgView.backgroundColor = select
        cell.selectedBackgroundView = cellSelectedBgView
        
        return cell
    }
   // Tableの機能
    func tableView(Tooltable: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    switch indexPath.row{
    case 0:
        CollisionDetection(MenuList, ONOFF: false)
        MenuList.animation = "slideRight"
        MenuList.animate()
    case 1:
        drawingView.drawTool = ACEDrawingToolTypePen
    case 2:
        drawingView.drawTool = ACEDrawingToolTypeLine
    case 3:
        Ellipse_S.hidden = false
        Ellipse_F.hidden = false
    case 4:
        Rect_S.hidden = false
        Rect_F.hidden = false
    case 5:
        drawingView.drawTool = ACEDrawingToolTypeEraser
    case 6:
        drawingView.drawTool = ACEDrawingToolTypeText
    default:
    break
    }
        if indexPath.row != 3{
            Ellipse_F.hidden = true
            Ellipse_S.hidden = true
        }
        if indexPath.row != 4{
            Rect_F.hidden = true
            Rect_S.hidden = true
        }
    }
 
    
    
    /*--- MenuList　action ---*/
    // 保存,新規作成,home,新規作成
    
    // 保存  //
    @IBOutlet weak var STitleError: UILabel!
    @IBOutlet weak var SCategoryError: UILabel!
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var CategoryField: UITextField!
    @IBOutlet var saveButton: SpringButton!
    
    
    var PostTitle :String = ""
    var PostCategory :Int = 10
    
    var myToolBar: UIToolbar!
    
    
    @IBAction func Save(sender: AnyObject) {
        
        MenuList.animation = "fadeOut"
        MenuList.animate()
        CollisionDetection(SaveView, ONOFF: false)
        SaveView.animation = "slideDown"
        SaveView.animate()
        CategoryField.placeholder = "カテゴリを選択してください"
        TitleField.placeholder = "タイトルを入力してください(1~15文字)"
        
    }
    
    //タイトル入力
    //文字数制限
    func textField(TittleField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // 文字数最大を決める.
        let maxLength: Int = 15
        // 入力済みの文字と入力された文字を合わせて取得.
        let str = TittleField.text! + string
        // 文字数がmaxLength以下ならtrueを返す.
        if str.characters.count <= maxLength {
            return true
        }
        return false}
    
    //改行した時キーボードを閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    
    //カテゴリ選択
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategoryArray.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryArray[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CategoryField.text = CategoryArray[row] as? String
        PostCategory = row
    }
    func onClick(sender: UIBarButtonItem) {
        CategoryField.resignFirstResponder()
    }
    
    
    
    
    @IBAction func SavePost(sender: AnyObject) {
        PostTitle = TitleField.text!
        let UserID:String = "testA"
        self.view.endEditing(true);
        
        //エラー処理
        if PostTitle.characters.count != 0{
            SaveFlag.0 =  1
        }
        
        if PostCategory != 10 {
            SaveFlag.1 =  1
        }
        
        
        switch SaveFlag{
        case (0,0):
            STitleError.text = "タイトルが入力されていません。"
            SCategoryError.text = "カテゴリが選択されていません。"
        case(0,1):
            STitleError.text = "タイトルが入力されていません。"
            SCategoryError.text = ""

        case (1,0):
            STitleError.text = ""
            SCategoryError.text = "カテゴリが選択されていません。"
        case(1,1):
            STitleError.text = ""
            SCategoryError.text = ""
        default:
            ErrorWindow()
                }
        
        
        
        if SaveFlag.1 == 1 && SaveFlag.0 == 1 && drawingView.image != nil{
            
            let PostImg: String = Image2String(drawingView.image)!;
            
            do {
                let reachability = try AMReachability.reachabilityForInternetConnection()
                if reachability.isReachable() {
                    //インターネット接続あり
                    //送信文
                    SavePost(UserID,Title: PostTitle,Category: PostCategory,IMG: PostImg)
                    
                    let alertController = UIAlertController(title: "保存完了", message: "Webページからダウンロードしてご使用ください。", preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default) {
                        action in
                        
                        self.CollisionDetection(self.SaveView, ONOFF: true)
                        
                    }
                    alertController.addAction(defaultAction)
                    
                    presentViewController(alertController, animated: true, completion: nil)
                    
                } else {
                    //インターネット接続なし
                    let alertController = UIAlertController(title: "インターネット接続エラー", message: "インターネットに接続されていないため保存できません。", preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    presentViewController(alertController, animated: true, completion: nil)
                    
                    
                }
            } catch _ as ReachabilityError {
                // エラー処理
                ErrorWindow()
            } catch _ as NSError {
                // NSErrorが投げられた場合
                ErrorWindow()
            } catch {
            // その他ハンドル出来なかったもの
                ErrorWindow()
            }
            
            
          /*  print(PostTitle)
            print(PostTitle.characters.count)
            print(CategoryField.text)
            print(PostCategory)*/

        }else{
            saveButton.animation = "shake"
            saveButton.animate()
        }
    }
    
    
    //ポストの処理
    func PostTest(UserID: String ,PW:String) {
        let request: Request = Request()
        
        let url: NSURL = NSURL(string:"http://paint.fablabhakodate.org/loginuser")!
        let body:NSMutableDictionary =
        NSMutableDictionary()
        
        body.setValue(PW, forKey: "password")
        body.setValue(UserID, forKey: "userid")
       
        
        
        request.post(url, body: body, completionHandler: {data, response, error in
            //code
        })
    }

    
    
    
    
    //ポストの処理
    func SavePost(UserID: String ,Title: String, Category: Int, IMG: String) {
        let request: Request = Request()
        
        let url: NSURL = NSURL(string:"http://paint.fablabhakodate.org/addpic")!
        let body:NSMutableDictionary =
        NSMutableDictionary()
        
        body.setValue(IMG, forKey: "filedata")
        body.setValue(Title, forKey: "title")
        body.setValue(UserID, forKey: "userid")
        body.setValue(Category, forKey: "category")
        
        
       request.post(url, body: body, completionHandler: {data, response, error in
            //code
        })
    }
    
    @IBAction func SaveCancel(sender: AnyObject) {
        CollisionDetection(SaveView, ONOFF: true)
    }
    
    
    //画像をNSDataに変換
    func Image2String(image:UIImage) -> String? {
        let data:NSData = UIImagePNGRepresentation(image)!
        //NSDataへの変換が成功していたら
         if let pngData:NSData = data {
        //BASE64のStringに変換する
        let encodeString:String =
        pngData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        return encodeString
        }

            return nil
        
    }
    
    
    
    // 新規作成
    @IBAction func NewCreate(sender: AnyObject) {
        
            SaveAlert("新規作成", ViewName: "selectGraphic")
        
    }
    
    
    // Home 
    //viewname変更
    @IBAction func Home(sender: AnyObject) {
        SaveAlert("Home", ViewName: "Home")
    }
    
    //検索
    //viewname変更
    @IBAction func Serch(sender: AnyObject) {
        SaveAlert("検索", ViewName: "Search")
    }
    
    
    
    
    
    
    /*--- 単体function ----*/
    
    
    //エラー画面
    func ErrorWindow(){
    let alertController = UIAlertController(title: "エラー", message: "予期せぬエラーが発生しました。\n再起動しますか?", preferredStyle: .Alert)
    let otherAction = UIAlertAction(title: "OK", style: .Default) {
        action in print("pushed OK!")
    }
    let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel, handler: nil)
        
    alertController.addAction(otherAction)
    alertController.addAction(cancelAction)
    presentViewController(alertController, animated: true, completion: nil)
    
    }
    
    //list on/of
    func CollisionDetection(view: SpringView,ONOFF:Bool){
        if ONOFF {
            Tooltable.userInteractionEnabled = true
            Ellipse_F.userInteractionEnabled = true
            Ellipse_S.userInteractionEnabled = true
            Rect_F.userInteractionEnabled = true
            Rect_S.userInteractionEnabled = true
            L_width1.userInteractionEnabled = true
            L_width2.userInteractionEnabled = true
            L_width3.userInteractionEnabled = true
            Reset.userInteractionEnabled = true
            UnDo.userInteractionEnabled = true
            ReDo.userInteractionEnabled = true
            drawingView.userInteractionEnabled = true
            view.animation = "fadeOut"
            view.animate()
           
            
        }else {
            Tooltable.userInteractionEnabled = false
            Ellipse_F.userInteractionEnabled = false
            Ellipse_S.userInteractionEnabled = false
            Rect_F.userInteractionEnabled = false
            Rect_S.userInteractionEnabled = false
            L_width1.userInteractionEnabled = false
            L_width2.userInteractionEnabled = false
            L_width3.userInteractionEnabled = false
            Reset.userInteractionEnabled = false
            UnDo.userInteractionEnabled = false
            ReDo.userInteractionEnabled = false
            drawingView.userInteractionEnabled = false
            view.hidden = false
        }
    }
    
    //未保存時の画面移動アラート
    
    func SaveAlert(Title: String, ViewName: String){
         if  SaveFlag.1 == 0 && SaveFlag.0 == 0{
        let alertController = UIAlertController(title: Title, message: "編集した画像が保存されていません。\n保存しますか?", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "保存", style: .Default) {
            action in
            // 保存ウィンドウの表示
            self.MenuList.animation = "fadeOut"
            self.MenuList.animate()
            self.CollisionDetection(self.SaveView, ONOFF: false)
            self.SaveView.animation = "slideDown"
            self.SaveView.animate()
        }
        let goAction = UIAlertAction(title: "保存しない", style: .Default) {
            action in
            
            //概形選択へ移動
            
            let targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( ViewName )
            self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
            }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel, handler: nil)
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        alertController.addAction(goAction)
        presentViewController(alertController, animated: true, completion: nil)
         }else{
            let targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( ViewName )
            self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
        }

    
    }
    
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
