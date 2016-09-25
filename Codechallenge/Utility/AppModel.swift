//
//  AppModel.swift
//  Aloha
//  Codechallenge
//
//  Created by Hamsa on 25/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

enum Gender:String {
    case Female = "Female"
    case Male = "Male"
    case Unknown = "Unknown"
}

struct ImageModel {
    var link:String = ""
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    init(imageDict:NSDictionary) {
        self.height = imageDict["height"] as! CGFloat
        self.width = imageDict["width"] as! CGFloat
        self.link = Utility.convertOptionalObjToString(imageDict["link"])
    }
}


struct NewsModel {
    var title:String = ""
    var authors:String = ""
    var standFirst:String = ""
    var originalSource:String = ""
    var body:String = ""
    var dateUpdated:String = ""
    var contentType:String = ""
    var thumbnailImage:ImageModel?
    var heroImage:ImageModel?

    init(newsInfo:NSDictionary) {
        let dateUpdated = Utility.convertOptionalObjToString(newsInfo["dateUpdated"])
        self.dateUpdated = dateUpdated.convertToLocalDate()

        self.body = Utility.convertOptionalObjToString(newsInfo["body"])

        self.title = Utility.convertOptionalObjToString(newsInfo["title"])
        if let authors = newsInfo["authors"] as? NSArray {
            for author in authors{
                self.authors += Utility.convertOptionalObjToString(author)
            }
        }
        self.standFirst = Utility.convertOptionalObjToString(newsInfo["standFirst"])
        
        self.originalSource = Utility.convertOptionalObjToString(newsInfo["originalSource"])

        if let imageDict = newsInfo["thumbnailImage"] as? NSDictionary {
            let thumbnailImage = ImageModel.init(imageDict: imageDict)
            self.thumbnailImage = thumbnailImage
        }
        
        // Hero image: if there is an Image matches width = 650, referenceType=”PRIMARY”
        if let relateds = newsInfo["related"] as? [NSDictionary]  {
            for related in relateds {
                let referenceType = Utility.convertOptionalObjToString(related["referenceType"])
                let width = related["width"] as! Int
                if referenceType == "PRIMARY"
                    && width == 650{
                    let heroImage = ImageModel.init(imageDict: related)
                    self.heroImage = heroImage
                    break
                }
            }
        }
    }
}


