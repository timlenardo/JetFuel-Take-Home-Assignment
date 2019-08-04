//
//  ViewController.swift
//  JetFuel Take-Home
//
//  Created by Pradyumn Nukala on 8/2/19.
//  Copyright © 2019 Pradyumn Nukala. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UITableViewController {
    // Data Reference
    var arrRes = [[String:AnyObject]]()
    
    // Adding RefreshControl
    var refreshTool = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data Request
        fetchData()
        
        // Manage TableView
        refreshTool.addTarget(self, action: #selector(refresh( sender:)), for: .valueChanged)
        tableView.insertSubview(refreshTool, at: 0)
    }
    
    // TableView Count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    // Refresh Data
    @objc func refresh(sender: UIRefreshControl) {
        sender.beginRefreshing()
        // refresh tableview datasource
        fetchData()
        sender.endRefreshing()
    }
    
    func fetchData(){
        let url = "http://www.plugco.in/public/take_home_sample_feed"
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["campaigns"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // ************************
    // -- Table Cell Setup --
    // ************************
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Disable Separator for Table Cell
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        
        // Disable TableCell Selection
        tableView.allowsSelection = false
        
        // Data for Row
        var data = arrRes[(indexPath as NSIndexPath).row]
        
        // Initialize Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        if (cell != nil) {
            cell.campaign_name.text = (data["campaign_name"] as! String)
            cell.pay_per_install.text = (data["pay_per_install"] as! String)
            cell.campaign_icon_url.downloaded(from: data["campaign_icon_url"] as! String)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  351;
    }
}

// *********************************
// -- Collection Card Cell Setup --
// *********************************
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rowData = arrRes[collectionView.tag]
        var medias = [[String:AnyObject]]()
        medias = rowData["medias"] as! [[String : AnyObject]]
        return medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Initialize
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! CardViewCell
        
        if(cell != nil){
            // Get Data from Row
            var rowData = arrRes[collectionView.tag]
            var medias = [[String:AnyObject]]()
            medias = rowData["medias"] as! [[String : AnyObject]]
            var data = medias[(indexPath as NSIndexPath).row]
            
            // Set Values
            cell.cover_photo_url.downloaded(from: data["cover_photo_url"] as! String)
            cell.trackingLink = data["tracking_link"] as! String
            cell.downloadURL = data["download_url"] as! String
            
            // Set Video Value
            var status: Bool = true
            if(data["media_type"] as! String == "video"){
                status = true
            }else{
                status = false
            }
            cell.setAsVideo(status: status)
            
        }
       
        // Return Card
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
