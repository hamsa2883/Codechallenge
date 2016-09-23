//
//  Utility.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

import SystemConfiguration

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

class Utility {
  
    class func convertStrToDescAttriuteStr(text:String)->NSAttributedString{
        let newString = text.stringByReplacingOccurrencesOfString("\n", withString: "<br>", options: NSStringCompareOptions.LiteralSearch, range: nil)

        let str = newString.stringByAppendingString(Constants.Config.formattedTextStyle)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(4.0)
        paragraphStyle.alignment=NSTextAlignment.Left
        var attrStr = NSMutableAttributedString()
        do {
            attrStr = try NSMutableAttributedString(
                data: str.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0,length: attrStr.length))
        } catch {
            print(error)
        }
        return attrStr
    }
    
    class func convertOptionalObjToString(obj:AnyObject?,replace:String="")->String{
        var toStr=replace
        if obj != nil && !(obj is NSNull)
        {
            toStr=obj as! String
        }
        return toStr
    }

    class func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
}

extension String{
    func convertToLocalDate() -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = Constants.Config.dateFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatter.dateFromString(self)
        
        if date != nil{
            dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle///this is you want to convert format
            dateFormatter.timeZone = NSTimeZone.systemTimeZone()
            let timeStamp = dateFormatter.stringFromDate(date!)
            
            return timeStamp
        }else{
            return ""
        }
    }
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
}
