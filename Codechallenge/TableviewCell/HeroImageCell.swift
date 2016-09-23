//
//  HeroImageCell.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class HeroImageCell: UITableViewCell {
    
    var imgV: UIImageView = UIImageView()
    var imageCache = [String:UIImage]()

    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(imgV);
        self.addBaseViewonstarinst()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCell(imageUrl: String){
        let imgURL = NSURL(string: imageUrl)
        let request: NSURLRequest = NSURLRequest(URL: imgURL!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            
            if error == nil {
                // Convert the downloaded data in to a UIImage object
                let image = UIImage(data: data!)
                // Update the cell
                dispatch_async(dispatch_get_main_queue(), {
                    self.imgV.image = image
                })
            }
            else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    func addBaseViewonstarinst(){
        imgV.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: imgV, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0.0)
        self.addConstraint(topConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: imgV, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0.0)
        self.addConstraint(bottomConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: imgV, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0.0)
        self.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: imgV, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0.0)
        self.addConstraint(rightConstraint)
    }

    
}