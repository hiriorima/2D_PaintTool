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

    
    @IBOutlet var drawingView: ACEDrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // ペン
    @IBAction func Pen(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypePen}
    
    // 直線
    @IBAction func Line(sender: AnyObject) {
        drawingView.drawTool = ACEDrawingToolTypeLine}
    
    
    
    
    
    
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
        drawingView.lineWidth = 10.0}
   
    @IBAction func Width2(sender: AnyObject) {
        drawingView.lineWidth = 20.0}

    @IBAction func Width3(sender: AnyObject) {
        drawingView.lineWidth = 30.0}
    
    
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
