//
//  CardViewCell.swift
//  JetFuel Take-Home
//
//  Created by Pradyumn Nukala on 8/3/19.
//  Copyright © 2019 Pradyumn Nukala. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    // IBOutlets For Card
    @IBOutlet weak var cover_photo_url: UIImageView!
    @IBOutlet weak var tracking_link: UIButton!
    @IBOutlet weak var download_url: UIButton!
    
    // Tracking Link Down
    @IBAction func tracking_link_touch(_ sender: Any) {
        print("Tracking Link Touched")
    }
    
    // Download Url Down
    @IBAction func download_url_touch(_ sender: Any) {
        print("Download URL Touched")
    }
}
