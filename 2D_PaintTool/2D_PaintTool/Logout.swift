//
//  Logout.swift
//  2D_PaintTool
//
//  Created by 会津慎弥 on 2015/12/05.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//

import UIKit

class Logout {
    
    func LogoutMethod(){
    
        let request: Request = Request()
        
        let url: NSURL = NSURL(string: "http://160.16.234.136:3000/logoutuser")!
        
        request.get(url, completionHandler: { data, response, error in
            // ToDo
            let MainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
            // アニメーションを設定.
            MainViewController!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
            
            // Viewの移動する.
       //     self.presentViewController(MainViewController, animated: true, completion: nil)

        })

        
    }

}
