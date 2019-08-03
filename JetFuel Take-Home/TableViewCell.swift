import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var campaign_name: UILabel!
    @IBOutlet weak var pay_per_install: UILabel!
    @IBOutlet weak var campaign_icon_url: UIImageView!
}

extension TableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        // Initialize Collection View
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor =  UIColor(red:0.89, green:0.94, blue:0.95, alpha:1.0).cgColor
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false)
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
