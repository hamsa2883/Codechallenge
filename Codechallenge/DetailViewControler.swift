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
    var storyPragraphs:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view .addSubview(tableView);
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "HeroImageCell")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DetailedCell")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "StoryPragraphCell")
        self.tableView.separatorStyle = .None
        
        self.tableView.estimatedRowHeight = 280
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.storyPragraphs = newsInfo!.body.componentsSeparatedByString("\n\n")
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
            return 2 + self.storyPragraphs.count
        }else{
            return 1 + self.storyPragraphs.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // If a hero image of withd 650 and type "PRIMARY" is prest the add the image
        if newsInfo?.heroImage != nil{
            if indexPath.row == 0 {
                let cell:HeroImageCell = HeroImageCell(style:UITableViewCellStyle.Default, reuseIdentifier:"HeroImageCell");
                cell.setCell(newsInfo!.heroImage!)
                cell.selectionStyle = .Default
                return cell;
            }else if indexPath.row == 1{
                let cell:DetailedCell = DetailedCell(style:UITableViewCellStyle.Default, reuseIdentifier:"DetailedCell");
                cell.setCell(newsInfo!)
                cell.selectionStyle = .Default
                return cell;
            }else{
                let cell:StoryPragraphCell = StoryPragraphCell(style:UITableViewCellStyle.Default, reuseIdentifier:"StoryPragraphCell");
                let storyText = self.storyPragraphs[indexPath.row-2]
                cell.setCell(storyText)
                cell.selectionStyle = .Default
                return cell;
            }
        }else{
            if indexPath.row == 0{
                let cell:DetailedCell = DetailedCell(style:UITableViewCellStyle.Default, reuseIdentifier:"DetailedCell");
                cell.setCell(newsInfo!)
                cell.selectionStyle = .Default
                return cell;
            }else{
                let cell:StoryPragraphCell = StoryPragraphCell(style:UITableViewCellStyle.Default, reuseIdentifier:"StoryPragraphCell");
                let storyText = self.storyPragraphs[indexPath.row-1]
                cell.setCell(storyText)
                cell.selectionStyle = .Default
                return cell;
            }
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

