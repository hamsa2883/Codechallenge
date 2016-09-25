//
//  DetailViewControler.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class DetailViewControler: UIViewController {
    
    var tableView: UITableView = UITableView()
    var refreshControl: UIRefreshControl!
    var newsInfo:NewsModel?
    var imageCache = [String:UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view .addSubview(tableView);
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "HeroImageCell")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DetailedCell")
        self.tableView.separatorStyle = .None
        
        self.addTableViewConstarinst()
    }
    
    // Adding the table view constariants.
    func addTableViewConstarinst(){
        
        // dissable the AustoresingMask so that it doesnt conflic with the constariants added by the user
        tableView.translatesAutoresizingMaskIntoConstraints = false

        // Top constarin of the tableview to the top of the super view
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        view.addConstraint(topConstraint)
        
        // Bottom constarin of the tableview to the Bottom of the super view
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
        
        // Leading constarin of the tableview to the Leading of the super view
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        view.addConstraint(leadingConstraint)
        
        // Trailing constarin of the tableview to the Trailing of the super view
        let trailingConstraint = NSLayoutConstraint(item: tableView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        view.addConstraint(trailingConstraint)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
    }
}

extension DetailViewControler:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if newsInfo?.heroImage != nil {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // If a hero image of withd 650 and type "PRIMARY" is prest the add the image
        if newsInfo?.heroImage != nil
        && indexPath.row == 0{
            let cell:HeroImageCell = HeroImageCell(style:UITableViewCellStyle.Default, reuseIdentifier:"HeroImageCell");
            cell.setCell(newsInfo!.heroImage!.link)
            cell.selectionStyle = .Default
            return cell;
        }else{
            let cell:DetailedCell = DetailedCell(style:UITableViewCellStyle.Default, reuseIdentifier:"DetailedCell");
            cell.setCell(newsInfo!)
            cell.selectionStyle = .Default
            return cell;
        }
    }
}

extension DetailViewControler:UITableViewDelegate
{
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.setNeedsDisplay()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView=UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 0.0))
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if newsInfo?.heroImage != nil
            && indexPath.row == 0{
            let heroImageHeightRatio = newsInfo!.heroImage!.width/newsInfo!.heroImage!.height
            return ScreenSize.SCREEN_WIDTH/heroImageHeightRatio;
        }else{
            let title: UILabel = UILabel()
            let authors: UILabel = UILabel()
            let originalSource: UILabel = UILabel()
            let updatedDate: UILabel = UILabel()
            let body: UITextView = UITextView()

            title.frame = CGRectMake(0, 0, self.tableView.frame.size.width-20, CGFloat.max)
            authors.frame = CGRectMake(0, 0, self.tableView.frame.size.width-20, CGFloat.max)
            originalSource.frame = CGRectMake(0, 0, self.tableView.frame.size.width-20, CGFloat.max)
            updatedDate.frame = CGRectMake(0, 0, self.tableView.frame.size.width-20, CGFloat.max)
            body.frame = CGRectMake(0, 0, self.tableView.frame.size.width-20, CGFloat.max)

            title.numberOfLines = 2
            title.font = UIFont(name: Constants.Config.defaultBoldFont, size: Constants.Config.titleFontSize)!
            authors.font = UIFont(name: Constants.Config.defaultFontLight, size: Constants.Config.textFontSize)!
            originalSource.font = UIFont(name: Constants.Config.defaultFontLight, size: Constants.Config.textFontSize)!
            updatedDate.font = UIFont(name: Constants.Config.defaultNavFont, size: 14.0)!

            title.text = newsInfo!.title
            originalSource.text = newsInfo!.originalSource
            updatedDate.text = newsInfo!.dateUpdated
            authors.text = newsInfo!.authors
            
            let attrStr = Utility.convertStrToDescAttriuteStr(newsInfo!.body)
            body.attributedText = attrStr

            authors.sizeToFit()
            title.sizeToFit()
            originalSource.sizeToFit()
            updatedDate.sizeToFit()
            body.sizeToFit()

            return (title.frame.size.height+authors.frame.size.height+originalSource.frame.size.height+updatedDate.frame.size.height+body.frame.size.height+50);
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let headerView=UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 0.0))
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

