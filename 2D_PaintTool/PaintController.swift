//
//  PaintController.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/10/30.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit
import ACEDrawingView
class PaintController: UIViewController {

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
    
    @IBOutlet var Eraser: UIButton!
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // 円のボタン表示
    @IBAction func Ellipse(sender: AnyObject) {
        Ellipse_S.hidden = false
        Ellipse_F.hidden = false
    }
    
    // 四角のボタン表示
    @IBAction func Rect(sender: AnyObject) {
        Rect_S.hidden = false
        Rect_F.hidden = false
    }
    
    
    
    @IBAction func Menu(sender: AnyObject) {
        MenuList.hidden = false
    }
    
    
    @IBAction func MenuBack(sender: AnyObject) {
        MenuList.hidden = true
    }
    
    
    
    
    
    
    
    
    // ペン
    @IBAction func Pen(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypePen}
    
    // 直線
    @IBAction func Line(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypeLine}
    
    
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
    
    
    // 消しゴム
    @IBAction func Eraser(sender: AnyObject) {
        
        
        drawingView.drawTool = ACEDrawingToolTypeEraser}
    
    // テキスト
    @IBAction func Text(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypeText}
   
    
    
    

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

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
