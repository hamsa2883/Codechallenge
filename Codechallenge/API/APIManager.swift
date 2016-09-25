//
//  APIManager.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    override init() {
        super.init()
    }
    // MARK: - global setting
    
    func getDataWithOutParameters(get_url:String,successHandler: AnyObject -> Void,failureHandler:NSError -> Void){
        let headers = [
            "Content-Type":"application/json",
        ]
        Alamofire.request(.GET, get_url,headers: headers)
            .responseJSON { response in
                print("StatusCode: \(response.response?.statusCode)")
                if response.result.isSuccess{
                    successHandler(response.result.value!)
                }else{
                    print(response.result.error!)
                    // check if the access token has expired. If yes, get a new access token
                    failureHandler(response.result.error!)
                }
        }
    }
    
}
