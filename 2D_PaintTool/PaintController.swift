//
//  PaintController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/10/30.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit
import ACEDrawingView
class PaintController: UIViewController, UITableViewDataSource, UITableViewDelegate{


    // view & button　の宣言
    @IBOutlet var drawingView: ACEDrawingView!
    @IBOutlet var MenuList: UIView!
    
    @IBOutlet var Ellipse_S: UIButton!
    @IBOutlet var Ellipse_F: UIButton!
    @IBOutlet var Rect_S: UIButton!
    @IBOutlet var Rect_F: UIButton!
    
    @IBOutlet var L_width1: UIButton!
    @IBOutlet var L_width2: UIButton!
    @IBOutlet var L_width3: UIButton!
    
    @IBOutlet var Reset: UIButton!
    
    // 保存フラグ
    var SaveFlag : Int! = 0

    
    
    @IBOutlet var Tooltable: UITableView!
     let TImgArray: NSArray = ["Menu.png","Pen.png","Line.png","Ellipse.png","Rect.png","Eraser.png","Text.png"]
        
    
    
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
        
        // メニューリストの非表示
        MenuList.hidden = true
        
        //選択中背景の初期設定
        L_width1.backgroundColor = select
        // テーブルのスクロール固定
        Tooltable.scrollEnabled = false
        
        
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
            Reset.setImage(UIImage(named: "Reset1"), forState: UIControlState.Normal)
        case 2:
            Reset.setImage(UIImage(named: "Reset2"), forState: UIControlState.Normal)
            drawingView.frame = CGRectMake(170, 100, 700, 550)
            
        case 3:
            Reset.setImage(UIImage(named: "Reset3"), forState: UIControlState.Normal)
        case 0:
            let alertController = UIAlertController(title: "Hello!", message: "This is Alert sample.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        default:
            let alertController = UIAlertController(title: "BAD!", message: "This is Alert sample.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func MenuBack(sender: AnyObject) {
        MenuList.hidden = true
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
    @IBAction func Undo(sender: AnyObject) {
        drawingView.undoLatestStep()}
    
    // 進む
    @IBAction func Redo(sender: AnyObject) {
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
        drawingView.clear()}

    
    
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
        MenuList.hidden = false
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
 
    
    
    @IBAction func Save(sender: AnyObject) {
     SaveFlag = 1
    }
    
    
    @IBAction func NewCreate(sender: AnyObject) {
        if  SaveFlag == 0{
            
        let alertController = UIAlertController(title: "新規作成", message: "編集した画像が保存されていません。\n保存しますか?", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in
            // self.MenuList.hidden = true
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
            action in
            //概形選択へ移動
            let targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "selectGraphic" )
            self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
            }
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
        }else{
            let targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "selectGraphic" )
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
