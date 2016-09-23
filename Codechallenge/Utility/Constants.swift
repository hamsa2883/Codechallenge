//
//  Constants.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Host {

        static let url = "http://tcog.news.com.au/news/content/v2/collection/7df8c106d7b8abccec7f9512177f62c5?t_product=tcog&t_output=json&pageSize=10&maxRelatedLevel=2&includeRelated=true"
    }

    struct Config {
        //test
        static let textFontSize:CGFloat = 16.0
        static let titleFontSize:CGFloat = 20.0
        static let lineSpace:CGFloat = 5.0
        static let defaultFont="SFUIText-Light"
        static let defaultFontLight=".SFUIText-Light"
        static let defaultBoldFont=".SFUIText-Semibold"
        static let defaultNavFont=".SFUIText-Italic"
        static let formattedTextStyle="<style>body{font-family:'SFUIText-Light'; font-size:16px; color:#272727;} strong{font-family:'.SFUIText-Semibold'} em{font-family:'.SFUIText-Italic'}</style>"
        
        static let dateFormat="yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let apiDateFormat="dd/MM/yyyy"
    }
}