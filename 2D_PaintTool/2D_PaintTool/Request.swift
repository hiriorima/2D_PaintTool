//
//  Request.swift
//  2D_PaintTool
//
//  Created by 蛯名真紀 on 2015/11/25.
//  Copyright © 2015年 会津慎弥. All rights reserved.
//


import UIKit

class Request {
    let session: NSURLSession = NSURLSession.sharedSession()
    let nooooUrl = NSURL(string: "http://paint.fablabhakdoate.org/")
    
    // GET METHOD
    func get(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(nooooUrl!)
        let header  = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies!)
        
        request.HTTPMethod = "GET"
        request.allHTTPHeaderFields = header
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTaskWithRequest(request, completionHandler: completionHandler).resume()
    }
    
    // POST METHOD
    func post(url: NSURL, body: NSMutableDictionary, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        
        let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(nooooUrl!)
        let header  = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies!)
        
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions.init(rawValue: 2))
        } catch {
            // Error Handling
            print("NSJSONSerialization Error")
            return
        }
        session.dataTaskWithRequest(request, completionHandler: completionHandler).resume()
    }
    
    // PUT METHOD
    func put(url: NSURL, body: NSMutableDictionary, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions.init(rawValue: 2))
        } catch {
            // Error Handling
            print("NSJSONSerialization Error")
            return
        }
        session.dataTaskWithRequest(request, completionHandler: completionHandler).resume()
    }
    
    // DELETE METHOD
    func delete(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTaskWithRequest(request, completionHandler: completionHandler).resume()
    }
}
