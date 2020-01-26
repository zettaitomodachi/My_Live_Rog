//
//  PastCollectionViewCell.swift
//  My_Live_Rog
//
//  Created by 妙中美月 on 2019/12/02.
//  Copyright © 2019 妙中美月. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet var liveImageView: UIImageView!
    @IBOutlet var liveDateLabel: UILabel!
    @IBOutlet var liveTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!

    // viewcontrollerでいうviewdidload
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
