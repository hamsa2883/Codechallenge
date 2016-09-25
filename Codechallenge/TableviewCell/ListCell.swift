//
//  ListCell.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    var title: UILabel = UILabel()
    var authors: UILabel = UILabel()
    var standfirst: UILabel = UILabel()
    var imgV: UIImageView = UIImageView()
    var baseView:UIView = UIView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        
        self.standfirst.numberOfLines = 0
        self.title.numberOfLines = 2
        self.title.font = UIFont(name: Constants.Config.defaultBoldFont, size: Constants.Config.titleFontSize)!
        self.authors.font = UIFont(name: Constants.Config.defaultNavFont, size: Constants.Config.textFontSize)!
        self.standfirst.font = UIFont(name: Constants.Config.defaultFontLight, size: Constants.Config.textFontSize)!
        
        self.addSubview(self.baseView)
        self.addBaseViewonstarinst()
        self.baseView.addSubview(title);
        self.baseView.addSubview(imgV);
        self.baseView.addSubview(authors);
        self.baseView.addSubview(standfirst);
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
        title.text = newsInfo.title
        self.imgV.contentMode = .ScaleAspectFill
        self.imgV.clipsToBounds = true
        self.authors.text = newsInfo.authors
        self.standfirst.text = newsInfo.standFirst
    }
    
    func addChildViewConstraints(){
        title.translatesAutoresizingMaskIntoConstraints = false
        imgV.translatesAutoresizingMaskIntoConstraints = false
        authors.translatesAutoresizingMaskIntoConstraints = false
        standfirst.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        
        //make dictionary for views
        let viewsDictionary = [
            "title":self.title,
            "image":self.imgV,
            "authors":self.authors,
            "standfirst":self.standfirst]
        
        //position constraints
        
        //baseView
        let view_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[title]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += view_constraint_H
        
        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[title]-8-[image(75)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil, views: viewsDictionary)
        allConstraints += view_constraint_V
        
        //authors
        let authors_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[image(100)]-8-[authors]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += authors_constraint_H

        let authors_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[title]-8-[authors]",
            options:NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += authors_constraint_V

        //authors
        let standfirst_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[image]-8-[standfirst]-18-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += standfirst_constraint_H
        
        let standfirst_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[authors]-8-[standfirst]",
            options:NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += standfirst_constraint_V

        
        NSLayoutConstraint.activateConstraints(allConstraints)

    }
    
    func addBaseViewonstarinst(){
        baseView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: baseView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 10.0)
        self.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: baseView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10.0)
        self.addConstraint(verticalConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: baseView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 10.0)
        self.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: baseView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 10.0)
        self.addConstraint(widthConstraint)
    }

    
}
