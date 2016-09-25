//
//  ViewController.swift
//  Codechallenge
//
//  Created by Hamsa on 23/09/2016.
//  Copyright © 2016 Hamsa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView = UITableView()
    var refreshControl: UIRefreshControl!
    var newsInfo:[NewsModel] = []
    var imageCache = [String:UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view .addSubview(tableView);
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ListCell")
        self.addTableViewConstarinst()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(ViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        tableView.backgroundColor = UIColor.whiteColor()
        
        self.reloadData()
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
    
    // Network function to pull dat from the server.
    // dispact the netwirk call as the async task to it doesnt disturb the main(UI) task
    func getStoresData(callback: (error: NSError?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            APIData.sharedInstance.getData({ response in
                if let data = response["data"] as? NSDictionary{
                    if let results = data["results"] as? [NSDictionary]{
                        for result in results{
                            let newsInfo = NewsModel.init(newsInfo: result)
                            self.newsInfo.append(newsInfo)
                        }
                    }
                }
                callback(error: nil)
                }, failureHandler: { error in
                    callback(error: error)
            })
        })
    }
    
    func reloadData() {
        // start the refresh control on the main thread so the user knows the list is updating
        dispatch_async(dispatch_get_main_queue(), {
            self.refreshControl.beginRefreshing()
        })
        
        // doing the actual data fetch...
        // this will dispatch to a background thread on its own
        getStoresData({
            (error: NSError?) -> Void in
            
            // The callback could be called from any thread so dispatch back to the main UI thread to finish the UI updates
            dispatch_async(dispatch_get_main_queue(), {
                if error != nil {
                    // update the UI for the error
                    // Show an alert message for the user so he can refresh again
                    self.showAlert(message: "Something went wrong. Please try again later.")
                    
                } else {
                    // update the data in the table view and reload it
                    self.tableView.reloadData();
                }
                
                // Stop the refresh control
                self.refreshControl.endRefreshing()
            })
        })
    }
    
    // Once the refresh table view fetches fresh data the table view is reloaded with the new data
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.tableView.reloadData()
    }

    // native alter message to the user
    func showAlert(title:String="", message: String,buttonTitle:String="OK"){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: nil))
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
    }
}

extension ViewController:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.newsInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ListCell = ListCell(style:UITableViewCellStyle.Default, reuseIdentifier:"ListCell");
        let newsInfo = self.newsInfo[indexPath.row]
        cell.setCell(newsInfo)
        
        if newsInfo.thumbnailImage != nil {
            let url = newsInfo.thumbnailImage!.link
            let imgURL = NSURL(string: url)
            // Set the image to nil so that the reuse cell will not have a worng image before the image is loaded
            cell.imgV.image = nil
            // If this image is already cached, don't re-download
            if let img = imageCache[url] {
                dispatch_async(dispatch_get_main_queue(), {
                    cell.imgV.image = img
                })
            }else {
                // The image isn't cached, download the img data
                // Perform this in a background thread
                let request: NSURLRequest = NSURLRequest(URL: imgURL!)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                    
                    if error == nil {
                        // Convert the downloaded data in to a UIImage object
                        let image = UIImage(data: data!)
                        // Store the image in to the cache
                        self.imageCache[url] = image
                        // Update the cell
                        dispatch_async(dispatch_get_main_queue(), {
                            cell.imgV.image = image
                        })
                    }
                    else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                task.resume()
            }
        }
        return cell;
    }
}

extension ViewController:UITableViewDelegate
{
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.setNeedsDisplay()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView=UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 0.0))
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let newsInfo = self.newsInfo[indexPath.row]
        let title: UILabel = UILabel()
        let author: UILabel = UILabel()
        let standfirst: UILabel = UILabel()
        
        title.frame = CGRectMake(0, 0, self.tableView.frame.size.width-20, CGFloat.max)
        standfirst.frame = CGRectMake(0, 0, self.tableView.frame.size.width-128, CGFloat.max)
        
        title.numberOfLines = 2
        standfirst.numberOfLines = 0
        title.font = UIFont(name: Constants.Config.defaultBoldFont, size: Constants.Config.titleFontSize)!
        author.font = UIFont(name: Constants.Config.defaultNavFont, size: Constants.Config.textFontSize)!
        standfirst.font = UIFont(name: Constants.Config.defaultFontLight, size: Constants.Config.textFontSize)!

        title.text = newsInfo.title
        author.text = newsInfo.authors
        standfirst.text = newsInfo.standFirst
        
        author.sizeToFit()
        title.sizeToFit()
        standfirst.sizeToFit()
        
        var height = standfirst.frame.size.height + title.frame.size.height+author.frame.size.height
        if height < (75+title.frame.size.height+28) {
            height = (75+title.frame.size.height+28)
        }
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let headerView=UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 0.0))
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let newsInfo = self.newsInfo[indexPath.row]
        let detailedVC = DetailViewControler()
        detailedVC.newsInfo = newsInfo
        self.navigationController!.pushViewController(detailedVC, animated: true)
    }
    
}

