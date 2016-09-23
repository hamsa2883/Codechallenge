//
//  APIData.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class APIData: NSObject {
    private let httpManager:APIManager
    
    class var sharedInstance: APIData {
        struct Singleton {
            static let instance = APIData()
        }
        return Singleton.instance
    }
    
    
    override init() {
        httpManager = APIManager()
        super.init()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func getData(successHandler: AnyObject -> Void,failureHandler:NSError -> Void){
        httpManager.getDataWithOutParameters(Constants.Host.url, successHandler: successHandler, failureHandler: failureHandler)
    }
}
