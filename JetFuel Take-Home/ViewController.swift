//
//  ViewController.swift
//  JetFuel Take-Home
//
//  Created by Pradyumn Nukala on 8/2/19.
//  Copyright © 2019 Pradyumn Nukala. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // REST URL and Init Var
        let url = "http://www.plugco.in/public/take_home_sample_feed"
        var count = 5
        
        // Call Request
        Alamofire.request(url).responseWelcome { response in
            if let data = response.result.value {
                // Return Campaign Count
                count = data.campaigns.count
            }
        }
        
        // Return Count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Disable Separator for Table Cell
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        
        // Initialize Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        // REST URL
        let url = "http://www.plugco.in/public/take_home_sample_feed"
        
        // Call Request
        Alamofire.request(url).responseWelcome { response in
            if let data = response.result.value {
                cell.campaign_name.text = data.campaigns[indexPath.row].campaignName
                cell.pay_per_install.text = data.campaigns[indexPath.row].payPerInstall
                cell.campaign_icon_url.downloaded(from: data.campaigns[indexPath.row].campaignIconURL)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
