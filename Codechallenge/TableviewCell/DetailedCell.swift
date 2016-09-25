//
//  DetailedCell.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class DetailedCell: UITableViewCell {
    
    var title: UILabel = UILabel()
    var authors: UILabel = UILabel()
    var originalSource: UILabel = UILabel()
    var updatedDate: UILabel = UILabel()
    var body: UITextView = UITextView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        
        self.title.numberOfLines = 2
        self.title.font = UIFont(name: Constants.Config.defaultBoldFont, size: Constants.Config.titleFontSize)!
        self.authors.font = UIFont(name: Constants.Config.defaultFontLight, size: Constants.Config.textFontSize)!
        self.originalSource.font = UIFont(name: Constants.Config.defaultFontLight, size: Constants.Config.textFontSize)!
        self.updatedDate.font = UIFont(name: Constants.Config.defaultNavFont, size: 14.0)!
        
        self.body.scrollEnabled = false
        self.body.editable = false

        self.addSubview(title);
        self.addSubview(authors);
        self.addSubview(originalSource);
        self.addSubview(updatedDate);
        self.addSubview(body);
        self.addChildViewConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCell(newsInfo: NewsModel){
        self.title.text = newsInfo.title
        self.originalSource.text = newsInfo.originalSource
        self.updatedDate.text = newsInfo.dateUpdated
        self.authors.text = newsInfo.authors
        
        let body = newsInfo.body
        let attrStr = Utility.convertStrToDescAttriuteStr(body)
        self.body.attributedText = attrStr
    }
    
    func addChildViewConstraints(){
        title.translatesAutoresizingMaskIntoConstraints = false
        originalSource.translatesAutoresizingMaskIntoConstraints = false
        authors.translatesAutoresizingMaskIntoConstraints = false
        updatedDate.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        
        //make dictionary for views
        let viewsDictionary = [
            "title":self.title,
            "originalSource":self.originalSource,
            "authors":self.authors,
            "updatedDate":self.updatedDate,
            "body":self.body]
        
        //position constraints
        
        //baseView
        let title_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[title]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += title_constraint_H

        let originalSource_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[originalSource]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += originalSource_constraint_H

        let authors_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[authors]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += authors_constraint_H

        let updatedDate_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[updatedDate]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += updatedDate_constraint_H

        let body_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[body]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += body_constraint_H

        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-8-[title]-8-[authors]-8-[originalSource]-8-[updatedDate]-8-[body]-8-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil, views: viewsDictionary)
        allConstraints += view_constraint_V
        
        NSLayoutConstraint.activateConstraints(allConstraints)

    }
    
}
