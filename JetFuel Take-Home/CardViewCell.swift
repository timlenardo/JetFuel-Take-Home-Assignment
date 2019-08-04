//
//  CardViewCell.swift
//  JetFuel Take-Home
//
//  Created by Pradyumn Nukala on 8/3/19.
//  Copyright © 2019 Pradyumn Nukala. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class CardViewCell: UICollectionViewCell {
    // IBOutlets For Card
    @IBOutlet weak var cover_photo_url: UIImageView!
    @IBOutlet weak var tracking_link: UIButton!
    @IBOutlet weak var download_url: UIButton!
    
    // Reference Values
    var trackingLink : String = ""
    var downloadURL : String = ""
    
    
    // Tracking Link Down
    @IBAction func tracking_link_touch(_ sender: Any) {
        // Copy Link to Clipboard
        let pasteboard = UIPasteboard.general
        pasteboard.string = trackingLink
        print(trackingLink)
        
        // Present Popup Informing User Link Copied
     self.noticeSuccess("Copied Link!")
        var timer = Timer()
        let delay = 1.0
        
        // cancel the timer in case the button is tapped multiple times
        timer.invalidate()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(delayedAction), userInfo: nil, repeats: false)
        
    
    }
    
    // Download Url Down
    @IBAction func download_url_touch(_ sender: Any) {
        // Save from Download URL
        if let url = URL(string: self.downloadURL),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        print(self.downloadURL)
        // Present Popup Informing User Media Saved to Library
        self.noticeSuccess("Media Saved!")
        var timer = Timer()
        let delay = 1.0
        
        // cancel the timer in case the button is tapped multiple times
        timer.invalidate()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.delayedAction), userInfo: nil, repeats: false)
    }
    
    // function to be called after the delay
    @objc func delayedAction() {
        self.clearAllNotice()
    }
}
