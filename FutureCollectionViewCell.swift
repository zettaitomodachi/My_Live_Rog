//
//  FutureCollectionViewCell.swift
//  
//
//  Created by 妙中美月 on 2020/01/12.
//

import UIKit

class FutureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet var liveImageView: UIImageView!
    @IBOutlet var liveDateLabel: UILabel!
    @IBOutlet var liveTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func sss(text: String) {
        
    }
    
    func configure(liveImage: UIImage, liveDate: String, liveTitle: String, artist: String) {
        liveImageView.image = liveImage
        liveDateLabel.text = liveDate
        liveTitleLabel.text = liveTitle
        artistLabel.text = artist
        
    }
}
