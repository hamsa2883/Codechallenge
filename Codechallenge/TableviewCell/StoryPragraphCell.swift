//
//  StoryPragraphCell.swift
//  Codechallenge
//
//  Created by Hamsa on 25/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class StoryPragraphCell: UITableViewCell {
    
    var storyText: UITextView = UITextView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        
        self.storyText.scrollEnabled = false
        self.storyText.editable = false

        self.addSubview(storyText);
        self.addChildViewConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCell(storyText: String){
        let body = storyText
        let attrStr = Utility.convertStrToDescAttriuteStr(body)
        self.storyText.attributedText = attrStr
    }
    
    func addChildViewConstraints(){
        storyText.translatesAutoresizingMaskIntoConstraints = false
        
        var allConstraints = [NSLayoutConstraint]()
        
        //make dictionary for views
        let viewsDictionary = [
            "storyText":self.storyText]
        
        //position constraints
        
        //baseView
        let storyText_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[storyText]-10-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        allConstraints += storyText_constraint_H

        let storyText_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-8-[storyText]-8-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil, views: viewsDictionary)
        allConstraints += storyText_constraint_V
        
        NSLayoutConstraint.activateConstraints(allConstraints)

    }
    
}
